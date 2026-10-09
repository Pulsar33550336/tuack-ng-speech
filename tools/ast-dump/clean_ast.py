"""把 tuack-ng-parser 的 {:#?} 输出整理成"无 span"的紧凑形式。

- 丢掉每个节点的 span 字段，并拆掉 Spanned 外壳
- 单行体压成一行，长度上限 76 字符
"""
import sys

ind = lambda l: len(l) - len(l.lstrip())


def dedent(line, n):
    k = min(n, len(line) - len(line.lstrip()))
    return line[k:]


def unwrap(lines):
    """拆掉一层 Spanned 外壳（反复调用直到没有）"""
    out, i, hit = [], 0, False
    while i < len(lines):
        l = lines[i]
        if l.strip() == 'Spanned {':
            hit = True
            base = ind(l)
            j = i + 1
            assert lines[j].strip().startswith('value: '), lines[j]
            val = [' ' * base + lines[j][ind(lines[j]) + len('value: '):]]
            j += 1
            while not (ind(lines[j]) == base + 4 and lines[j].strip().startswith('span:')):
                val.append(lines[j]); j += 1
            while not (ind(lines[j]) == base and lines[j].strip() in ('}', '},')):
                j += 1
            j += 1
            out.append(val[0])
            out += [dedent(v, 4) if v.strip() else '' for v in val[1:]]
            i = j
            continue
        out.append(l); i += 1
    return out, hit


def collapse(lines):
    """把「体是平的」块压成一行（从内往外，反复直到稳定）。

    体是平的 = 内部没有别的开括号行。压的时候不插逗号，只去掉末项那个。
    """
    changed = True
    while changed:
        changed, out, i = False, [], 0
        while i < len(lines):
            l, s, k = lines[i], lines[i].strip(), ind(lines[i])
            if s.endswith(('(', '[', '{')):
                closer = {'(': ')', '[': ']', '{': '}'}[s[-1]]
                j = i + 1
                while j < len(lines) and not (ind(lines[j]) == k
                                              and lines[j].strip() in (closer, closer + ',')):
                    j += 1
                if j < len(lines):
                    body = [x.strip() for x in lines[i + 1:j] if x.strip()]
                    flat = not any(x.endswith(('(', '[', '{')) for x in body)
                    if flat and body:
                        parts = list(body)
                        parts[-1] = parts[-1].rstrip(',')
                        joined = l.rstrip() + ' '.join(parts) + lines[j].strip()
                        if len(joined) <= 76:
                            out.append(joined); i = j + 1; changed = True; continue
            out.append(l); i += 1
        lines = out
    return lines


src = open(sys.argv[1]).read().split('\n')
lines = [l for l in src]
while True:
    lines, hit = unwrap(lines)
    if not hit:
        break
# parser 的 {:#?} 把 Document 的第一个字段打在顶格，补回来
for k in range(len(lines) - 1):
    if lines[k].strip() == 'Document {' and lines[k + 1].strip() == 'blocks: [':
        lines[k + 1] = '    ' + lines[k + 1].lstrip()

def drop_table(lines):
    """扬掉 Table 节点（太长），原位留一行标记"""
    out, i = [], 0
    while i < len(lines):
        l = lines[i]
        if l.strip().startswith('Table('):
            k = ind(l)
            j = i + 1
            while j < len(lines) and not (ind(lines[j]) == k
                                          and lines[j].strip() in (')', '),')):
                j += 1
            out.append(' ' * k + '// Table（略）')
            i = j + 1
            continue
        out.append(l); i += 1
    return out


lines = drop_table(lines)
lines = collapse(lines)
open(sys.argv[2], 'w').write('\n'.join(lines))
print(f'{sys.argv[2]}: {len(lines)} 行，剩余 Spanned: {sum(1 for l in lines if l.strip() == "Spanned {")}')
