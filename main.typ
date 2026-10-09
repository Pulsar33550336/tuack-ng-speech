#import "@preview/xwysyy:0.4.0": *
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/fletcher:0.5.8": diagram, edge, node
#show: show-cn-fakebold

#show: xwysyy-pre.with(
  theme: "sky",
  font: "LXGW WenKai",
  heading-font: "LXGW WenKai",
  code-font: "Maple Mono Normal NL NF",
  lang: "zh",
  config-info(
    title: [Tuack-NG],
    subtitle: [请输入文本],
    author: "Pulsar2021",
    date: datetime.today(),
    // institution: "LCA 营（MS Attached to NWPU）",
  ),
  // config-common(show-notes-on-second-screen: right),
)

#set align(horizon)
#set text(size: 20pt, weight: "medium")
#show strong: it => text(size: 20pt, weight: "bold", it.body)
#show heading.where(level: 3): it => {
  set text(size: 24pt)
  it.body
}
#title-slide()

#let sep = line(length: 100%)

#let script(it) = speaker-note[
  #set text(size: 18pt)
  #it
]

#script[
  大家好，我是 Tuack-NG 的开发者兼设计者，很高兴有这样一个机会，向大家介绍我的项目。

  到目前为止，这应该是唯一一次不讲 OI 知识的讲演，希望大家抓紧这个机会听一听权当放松，#strike[因为我的同学 lbc 一会就要拿数论知识轰炸大家了。]

  如果大家经常翻洛谷文章区的话，应该能看到大概四次有关于 Tuack-NG 的内容：第一次是我刚刚画完饼，向洛谷社区公布计划的时候；第二次是我开发了一段时间，向社区公布开发进度；第三次是在 1.0 的 rp 阶段时征集用户测试（虽然似乎也没啥用）；最后一次则是 1.0 发布后的宣传文章。

  #sep

  首先，我们来回顾一些内容。
]

#outline-slide()

= 前言

#script[
  在演讲之前，我在群中发布了一张问卷。截止统计时共有 15 人提交了问卷，另有 1 位天津老哥以身犯险，不在营中却提交了问卷。

  另外，我看到了两张别开生面的答卷：
]

感谢大家提供的问卷信息，这为我带来了很多便利。不过：

#pause

#image("./assets/image2.png")

#pause

#image("./assets/image.png")

#pause

……

== 怎么出一道题

#script[
  在讲解一个出题工具前，我们来回顾一下：怎么出一道题。
]

在讲解出题工具前，我们来回顾一下怎么出一道题。

=== Idea

#script[
  首先我们要有一个 Idea，但这主要是思维和创造性的工作，而不是工具可以辅助的（除非你用生成式预训练变形金刚辅助出题），并且因人而异。

  因此，这次讲演我们将不再赘述这一阶段。
]

首先我们要有一个 Idea。这不是本次讲演的重点，我们跳过。

#pause

=== 题面

#script[
  然后，我们便要编写一个（美观）的题面。常见的将题面生成为 PDF 方法有：Markdown 转 PDF、LaTeX / Typst、以及使用上述工具生成标准样式题面的工具，比如 Tuack（使用 LaTeX），CNOI / Tuack-NG（使用 Typst）。
]

有了 Idea 后，我们便要*着手编写合适的题面*。

#pagebreak()

=== 数据 & 标程

#script[
  随后，我们需要为题目编写标准程序，即 Std；并通过某些方法生成数据。常见的方法有写一个数据生成器或使用某些造数据框架（比如 Tuack(-NG)、Polygon）来使上一种方法更加便携。
]

然后，我们要*编写标准答案*，并使用某些方法*生成数据*。

#pause

=== 导出

#script[
  最后，根据需要的目标，我们需要将题面和/或样例与下发文件导出到 OJ 或评测机，以及下发给做题人。
]

最后，我们需要使用某种方法*将数据/题面导出到评测平台*。

== 常见的一些问题/痛点

#script[
  在收集的 15 份问卷中，大部分答卷都指出了这些问题：
]

在问卷调查中，大家表示有以下几个比较普遍的痛点：

+ *题面不美观*，不像 CCF 的题面 / 没有优秀的 PDF 生成器
+ 造出过「零分之一」这种*错误数据*
+ 造数据时，需要*机械性的修改*文件输入输出和 / 或数据限制，甚至*反复生成*一组数据
+ 造出的数据 / 样例*强度太弱*
+ 想用 Tuack / Tuack-NG / Hull 等工具，但是*文档难读，或者门槛太高*

这次讲演，我将尝试讲解：Tuack-NG 可以解决哪些问题。

= Tuack-NG 能做什么？

说了这么多，Tuack-NG 可以做什么呢？

== 题面

Tuack-NG 开发时的第一个目标便是辅助题目相关的所有环节。

== 题面 - 语法

Tuack-NG 使用 Markdown 编写题面，并且支持*所有 CNOI 语法*。

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: (x: 40pt, y: 4pt),
  table.header([*语法*], [*写法*]),
  [*表格合并*], [`^` 向上合并、`<` 向左合并],
  [*图片属性*], [`![示意图](img/a.png){width=60%}`],
  [*公式*], [`$O(n \log n)$`、块级 `$$ ... $$`],
  [*容器*], [`:::figure{caption="图 1"}`],
  [*脚注*], [`[^1]`],
  [*GFM*], [表格、删除线、自动链接……],
  table.cell(colspan: 2, align: left)[以及一些额外语法],
  [*对齐*], [`:::align{right}`],
)

#{
  set align(top)
  compare-slide(
    title: [题面 - 语法],
    left: card[
      #align(center)[#text(size: 14pt)[*题面源码*]]
      #set text(size: 11pt)
      #raw(read("assets/cnoi-syntax.md"), lang: "md")
    ],
    right: card[
      #align(center)[#text(size: 14pt)[*渲染结果*]]
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 10pt,
        align(center)[
          #image("assets/cnoi-syntax.png", height: 235pt)
          #text(size: 15pt)[Tuack-NG]
        ],
        align(center)[
          #image("assets/cnoi-syntax-cnoi.png", height: 235pt)
          #text(size: 15pt)[CNOI]
        ],
      )
    ],
  )
}

// ---------------------------------------------------------------- 题面 - 语法 - 模板系统
// 左 = statement.md 原文，右 = 同一段展开之后；一对「模板 ↔ 展开」一种颜色
#let MCODE = 9pt
#let MLH = 10pt
#let mono(s, size: MCODE) = text(font: "Maple Mono Normal NL NF", size: size, s)
#let band(c, s, size: MCODE, lh: MLH, inset: (x: 0.3em), radius: 0.3em) = box(
  fill: c,
  inset: inset,
  radius: radius,
  height: 1.02 * lh,
  align(horizon, mono(s, size: size)),
)
#let m1 = rgb("#9ec9f5") // input_file
#let m2 = rgb("#ffd166") // data | length
#let m3 = rgb("#9ee493") // tools.cases
#let m4 = rgb("#f7a8c4") // output_file
#let m5 = rgb("#c3aaf0") // sample.text
#let m6 = rgb("#7fd4cf") // sample.file
#let m7 = rgb("#ffcf9c") // 题面 - AST：Container
#let m8 = rgb("#cfe8a9") // 题面 - AST：caption
#let m9 = rgb("#d9c2f0") // 题面 - AST：Emphasis

// m10 起是备用色，随便取用；要调色直接改这里
#let m10 = rgb("#e8a4a4") // 红
#let m11 = rgb("#a8c4e0") // 钢蓝（比 m1 深）
#let m12 = rgb("#d8c48c") // 沙金
#let m13 = rgb("#9fd0b8") // 薄荷（比 m6 深）
#let m14 = rgb("#c0a8d8") // 紫（比 m5 深）

// 代码面板外观（模板系统 / 外置表格 / Markdown 导出共用）
#let panel(body, inset: (x: 10pt, y: 4pt)) = block(
  fill: skyll,
  inset: inset,
  radius: 3pt,
  width: 100%,
  body,
)

// 代码面板：统一走主题的 block raw。
// 主题把它压到 0.9em，所以这里按「实际字号」书写，由 helper 换算。
#let code(body, size: 11pt) = text(size: size / 0.9, body)

#let mrow(body, lh: MLH) = box(height: lh, align(left + horizon, body))
#let mcol(items, size: MCODE, lh: MLH) = panel({
  set text(size: size)
  set par(leading: 0pt)
  items.map(i => mrow(i, lh: lh)).join(linebreak())
})

#let m-left = (
  mono("## 输入格式"),
  [],
  band(m1, "{{ statement.input_file() }}"),
  [],
  mono("输入的第一行包含两个正整数 $n, m$。"),
  [],
  mono("共 ") + band(m2, "{{ problem.data | length }}") + mono(" 个测试点。"),
  [],
  band(m3, "{{ tools.cases([1,2,3,5,6,7,114,514]) }}"),
  [],
  mono("## 输出格式"),
  [],
  band(m4, "{{ s.output_file() }}"),
  [],
  band(m5, "{{ sample.text(1) }}"),
  // 右侧这一格展开成 12 行，这里补 12 行空行，下面才继续逐行对齐
  ..range(12).map(_ => []),
  mono("## 样例 2"),
  [],
  band(m6, "{{ sample.file(2) }}"),
)

#let m-right = (
  mono("## 输入格式"),
  [],
  band(m1, "从文件 *candy.in* 中读入数据。"),
  [],
  mono("输入的第一行包含两个正整数 $n, m$。"),
  [],
  mono("共 ") + band(m2, "20") + mono(" 个测试点。"),
  [],
  band(m3, "$1 \\sim 3,5 \\sim 7,114,514$"),
  [],
  mono("## 输出格式"),
  [],
  band(m4, "输出到文件 *candy.out* 中。"),
  [],
  band(m5, "## 样例 1 输入"),
  [],
  band(m5, "```txt"),
  band(m5, "1 10"),
  band(m5, "76842568 885429956"),
  band(m5, "```"),
  [],
  band(m5, "## 样例 1 输出"),
  [],
  band(m5, "```txt"),
  band(m5, "0"),
  band(m5, "```"),
  [],
  mono("## 样例 2"),
  [],
  band(m6, "见选手目录下的 *candy/candy2.in* 与 *candy/candy2.ans*。"),
)

== 题面 - 语法 - 模板系统

Tuack-NG 还支持更强大的*模板系统*。

#{
  set align(top)
  // 导语和两栏之间不要留默认的块间距
  set block(spacing: 12pt)
  grid(
    columns: (1fr, 1fr),
    column-gutter: 26pt,
    align: top,
    [
      #text(size: 15pt, weight: "bold")[你写的 `statement.md`]
      #v(2pt)
      #mcol(m-left)
    ],
    [
      #text(size: 15pt, weight: "bold")[展开模板后的结果]
      #v(2pt)
      #mcol(m-right)
    ],
  )
}

// ---------------------------------------------------------------- 题面 - 语法 - 外置表格
#let cblock(lines, size: 13pt, lang: none, leading: 0.3em, hl: -1, note: none) = panel(inset: (x: 10pt, y: 7pt), {
  set text(font: "Maple Mono Normal NL NF", size: size)
  set par(leading: leading, justify: false)
  let body = lines
    .enumerate()
    .map(((i, l)) => {
      let r = raw(l, lang: lang)
      if i == hl { highlight(fill: rgb("#ffe08a"), extent: 3pt, radius: 2pt, r) } else { r }
    })
    .join(linebreak())
  if note == none {
    body
  } else {
    // 备注放整个代码块的右下角
    grid(
      columns: (1fr, auto),
      column-gutter: 10pt,
      align: (left + bottom, right + bottom),
      body, raw(note, lang: lang),
    )
  }
})

#let tbl-jinja = (
  "| 测试点编号 | $T =$ | $N \\le$ | $\\lvert a_i \\rvert \\le$ |",
  "| :-: | :-: | :-: | :-: |",
  "{%- set prev_T = None %}",
  "{%- set prev_max_n = None %}",
  "{%- set prev_max_a = None %}",
  "{%- for group in data_cases %}",
  "| {{ tools.cases(group.id) }} | {% if group.args.T == prev_T %} ^ {% else %}${{ group.args.T }}${%- set prev_T = group.args.T %}{% endif %} | {% if group.args.max_n == prev_max_n %} ^ {% else %}${{ group.args.max_n }}${%- set prev_max_n = group.args.max_n %}{% endif %} | {% if group.args.max_a == prev_max_a %} ^ {% else %}${{ group.args.max_a }}${%- set prev_max_a = group.args.max_a %}{% endif %} |",
  "{%- endfor %}",
)

// 拿出来写：tables/1.lua（导数之殇的真实文件）

== 题面 - 语法 - 外置表格

手写的表会过时，那就用模板自动生成——可题面里就变成了一坨。

#v(4pt)
#cblock(tbl-jinja, size: 16pt, leading: 0.55em, hl: 6, note: "PS：高亮内容是一行 🤡")

---

同一张表，换成一个 Lua 文件。

#v(4pt)
#code(size: 12.5pt)[
  ```lua
  local il = tng.tools.inline_latex

  return tng.table {
      headers = { "测试点编号", il("T ="), il("N \\le"), il("\\lvert a_i \\rvert \\le") },
      align = { "center", "center", "center", "center" },

      data = tng.config.data_cases:map(function(group)
          local args = group.args
          return {
              tng.tools.cases(group.id),
              tng.tools.inline_latex(args.T),
              tng.tools.inline_latex(args.max_n),
              tng.tools.inline_latex(args.max_a)
          }
      end),

      merge_rules = {
          { col = 2, merge_row = true },
          { col = 3, merge_row = true },
          { col = 4, merge_row = true },
      },
  }
  ```
]

== 题面 - 渲染

// 同一份 `statement.md`，`ren` 一下换一套版面——连同封面。

Tuack-NG 支持多种渲染目标，包括但不限于 (C)NOI、CCPC 与 Markdown，且*可拓展*。

#v(6pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 26pt,
  align: (center + top, center + top),
  [
    #text(size: 22pt)[NOI]
    #image("assets/cover-noi-top.png", width: 100%)
  ],
  [
    #text(size: 22pt)[CCPC]
    #image("assets/cover-ccpc-top.png", width: 100%)
  ],
)

---

#let MD-CODE = 8.5pt
#let MD-LH = 12pt
#let md-hi(c, s) = band(c, s, size: MD-CODE, lh: MD-LH)
#let md-tx(s) = mono(s, size: MD-CODE)

// 三份导出共有的开头：两个标题各带一行正文（H 为标题层级）
#let md-head(H) = (
  md-hi(m1, H + " 输入格式"),
  md-tx(""),
  md-tx("第一行一个整数 $n$。"),
  md-tx(""),
  md-hi(m1, H + " 输出格式"),
  md-tx(""),
  md-tx("一行一个整数。"),
  md-tx(""),
)

#let md-plain = (
  ..md-head("##"),
  md-hi(m2, "| 测试点 | $n \\le$ |"),
  md-hi(m2, "| :----: | ------: |"),
  md-hi(m2, "|  $1$   |    $10$ |"),
  md-hi(m2, "|  $2$   |       ^ |"),
)

#let md-loj = (
  ..md-head("##"),
  md-hi(m2, "| 测试点<!--row:0,col: 0--> | $n \\le$<!--row:0,col: 1--> |"),
  md-hi(m2, "| :-----------------------: | -------------------------: |"),
  md-hi(m2, "|  $1$<!--row:1,col: 0-->   |    $10$<!--row:1,col: 1--> |"),
  md-hi(m2, "|  $2$<!--row:2,col: 0-->   |    $10$<!--row:1,col: 1--> |"),
)

#let md-uoj = (
  ..md-head("###"),
  md-hi(m2, "<table>"),
  md-hi(m2, "  <thead>"),
  md-hi(m2, "    <tr>"),
  md-hi(m2, "      <th align=\"center\"> 测试点 </th>"),
  md-hi(m2, "      <th align=\"right\"> $n \\le$ </th>"),
  md-hi(m2, "    </tr>"),
  md-hi(m2, "  </thead>"),
  md-hi(m2, "  <tbody>"),
  md-hi(m2, "    <tr>"),
  md-hi(m2, "      <td align=\"center\"> $1$ </td>"),
  md-hi(m2, "      <td rowspan=\"2\" align=\"right\"> $10$ </td>"),
  md-hi(m2, "    </tr>"),
  md-hi(m2, "    <tr>"),
  md-hi(m2, "      <td align=\"center\"> $2$ </td>"),
  md-hi(m2, "    </tr>"),
  md-hi(m2, "  </tbody>"),
  md-hi(m2, "</table>"),
)

Tuack-NG 的 Markdown 导出目标还可以针对目标进行调整，比如标题层级，表格等。

#v(-12pt)

#grid(
  columns: (1.2fr, 2.72fr, 2.5fr),
  column-gutter: 12pt,
  align: top,
  [
    #align(center)[#text(size: 16pt)[Markdown]]
    #v(-12pt)
    #mcol(md-plain, size: MD-CODE, lh: MD-LH)
  ],
  [
    #align(center)[#text(size: 16pt)[LOJ]]
    #v(-12pt)
    #mcol(md-loj, size: MD-CODE, lh: MD-LH)
  ],
  [
    #align(center)[#text(size: 16pt)[UOJ]]
    #v(-12pt)
    #mcol(md-uoj, size: MD-CODE, lh: MD-LH)
  ],
)

== 数据与测试

#v(4pt)
#grid(
  columns: (0.6fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    很多人是这么造数据的：
    #code(size: 14pt)[
      ```cpp
      #include <bits/stdc++.h>
      using namespace std;

      const int N = 10;
      const int M = 20;

      int main() {
          freopen("x.in", "w", stdout);
          srand(time(0));
          int n = rand() % N + 1;
          int m = rand() % M + 1;
          printf("%d %d\n", n, m);
          // ...
      }
      ```
    ]
    但参数和文件名写死在源码里，每跑一次就得改一次。
  ],
  [
    聪明些的写法：
    #code(size: 14pt)[
      ```cpp
      #include <bits/stdc++.h>
      using namespace std;
      const int T = 6;
      int N[] = { 1, 2, 2, 10, 100, 100000 };
      long long M[] = { 10, 20, 20, 100, 1000, 1000000000000000000LL };

      int main() {
          srand(time(0));
          for (int i = 0; i < T; ++i) {
              freopen((to_string(i + 1) + ".in").c_str(),
                      "w", stdout);
              // ...
          }
      }
      ```
    ]
    但*不可复现*：种子是 `time(0)`；就算种子固定，*改一个也得全部重造*——数组里插一个点，它后面所有点的随机序列都跟着变了。
  ],
)

== 数据与测试 - 生成器

与 Tuack-NG 集成时，生成器里不需要文件名、不需要「第几个测试点」、也不需要种子——只剩「把参数变成数据」这一件事。

#grid(
  columns: (0.75fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(size: 14pt)[
      ```cpp
      #include "testlib.h"

      int main(int argc, char* argv[]) {
          registerGen(argc, argv, 1);

          // 格式: n=... m=... seed=...
          int n = opt<int>("n", 5);
          long long m = opt<long long>("m", 20);
          long long seed =
              opt<unsigned long long>("seed", 0);

          rnd.setSeed(seed);

          cout << n << " " << m << endl;
          // ...
      }
      ```
    ]
  ],
  [
    参数从配置里来：
    #v(-8pt)
    #code(size: 14pt)[
      ```json
      "args": { "n": 100000, "m": 1000000000000000000 },
      "data": [
        {
          "id": [2,3], "score": 10,
          "args": { "n": 2, "m": 20 }
        },
        {
          "id": [19,20], "score": 10,
          "args": { "n": 100000, "m": 1000000000000000000 }
        },
      ]
      ```
    ]
    #v(-8pt)
    然后，生成器会被传入 `-n=2 -m=20 -seed=<...>`。
  ],
)

你只需要接收参数，将生成的数据打印到标准输出，剩下的全归 Tuack-NG 管。

== 数据与测试 - 生成器 - 种子

随机数种子不用你操心：Tuack-NG 给*每个测试点*生成一份，记在 `data/.seed` 里。

#v(6pt)
#grid(
  columns: (1fr, 1.15fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(size: 16pt)[
      ```json
      {
        "1": 12093443819787335159,
        "2": 12011163482082634790,
        "3": 13007200171360182696,
        // ...
        "20": 8648298818406258413
      }
      ```
    ]
  ],
  [
    #set align(horizon)
    Tuack-NG 也提供了操控种子重新生成的方法；
    生成器那边只需要一行 `rnd.setSeed(seed)`，而种子由 Tuack-NG 传进来。
  ],
)

#line(length: 100%, stroke: gray)

同样的 `args` 加同样的 `seed`，*换时间、换机器，出来的还是同一份数据*；

== 数据与测试 - 测试

想卡掉的错解，赛时才发现 AC 了？

在筹备阶段，把「它该得几分」提前写进配置，Tuack-NG 会帮你检查它在数据上的运行结果是否符合你的预期。

#grid(
  columns: (1.15fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(size: 16pt)[
      ```json
      "tests": {
        "std": {
          "expected": "== 100",
          "path": "tests/std.cpp"
        },
        "tests/b.cpp": {
          "expected": [">= 10", "<= 60"],
          "path": "tests/b.cpp"
        }
      }
      ```
    ]
  ],
  [
    #set align(horizon)

    期望分数写成表达式（`== 100`、`>= 10`），也可以给区间，满足各种需求。

    支持子任务（捆绑测试）与 SPJ。
  ],
)


== 数据与测试 - 校验

零分之一、树上造了个环？小数据可以自己盯，但动辄数 MB 的大数据怎么看？

让我们写个 Validator 让程序去看。

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(size: 16pt)[
      ```cpp
      // val/val.cpp
      #include "testlib.h"

      int main(int argc, char* argv[]) {
        registerValidation(argc, argv);

        int n = inf.readInt(1, 100000, "n");
        inf.readEoln();
        inf.readEof();
        return 0;
      }
      ```
    ]
  ],
  [
    #code(size: 16pt)[
      ```json
      "validator": {
        "data": {
          "source": "val/val.cpp",
          "deps": ["val/testlib.h"]
        }
      }
      ```
    ]
    同时，我们支持在生成数据时顺手校验，从源头解决问题。
  ],
)
#text(fill: gray)[碎碎念：Testlib 不支持在 Validator 里使用 `opt` 接收参数，TAT……]

== 导出

Lemon 一套、Arbiter 一套，CCR 一套……BOOM，换个评测平台就得把数据重新手配一遍。

#v(4pt)

Tuack-NG 帮你导出到评测平台。

#v(6pt)
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 18pt,
  align: top,
  [
    #align(center)[Lemon]

    #code(size: 12pt)[
      ```txt
      lemon/
      └── data/
          └── aplusb/
              ├── aplusb1.in
              ├── aplusb1.ans
              ├── aplusb2.in
              ├── aplusb2.ans
              └── ...
      ```
    ]
  ],
  [
    #align(center)[Arbiter]

    #code(size: 12pt)[
      ```txt
      arbiter/main/
      ├── setup.cfg
      ├── team.info
      ├── day<N>.info
      ├── task<N>_<M>.info
      ├── data/
      ├── evaldata/
      ├── final/
      ├── players/
      ├── result/
      ├── filter/
      ├── tmp/
      └── down/
      ```
    ]
  ],
  [
    #align(center)[CCR-Plus]

    #code(size: 12pt)[
      ```txt
      ccr-plus/
      ├── .ccr
      ├── data/aplusb/
      │   ├── .prb
      │   ├── 1.in
      │   ├── 1.ans
      │   └── <SPJ>
      ├── src/
      └── result/
      ```
    ]
  ],
)

== 小功能

#grid(
  columns: (1.3fr, 1fr),
  column-gutter: 24pt,
  align: top,
  [
    #text(size: 18pt, weight: "bold")[题面查错：`doc check` / `doc format`]
    #v(6pt)
    #text(size: 16pt)[
      #table(
        columns: (auto, auto, auto),
        stroke: none,
        inset: (x: 10pt, y: 4pt),
        table.header([改前], [], [改后]),
        [`小X开了一家糖果店`], [->], [`小 X 开了一家糖果店`],
        [`中文:英文`], [->], [`中文：英文`],
        [`ＡＢＣ１２３`], [->], [`ABC123`],
        [`价格是$x$元`], [->], [`价格是 $x$ 元`],
      )
    ]
    #v(8pt)
    检查题面里不符合规范的地方，能修的就顺手修掉。
  ],
  [
    #text(size: 18pt, weight: "bold")[批量改配置：`conf`]
    #v(6pt)
    #code(size: 14pt)[
      ```txt
      tuack-ng conf title "2025 模拟赛"
      tuack-ng conf time 2.0
      tuack-ng conf length 5h
      tuack-ng conf conf <字段> <值>
      tuack-ng conf migrate
      ```
    ]
    #v(8pt)
    在比赛日或比赛层级执行，一次改掉下面所有题目。
  ],
)

// 用法：#ruby[上方小字][基文]
#let ruby(rt, rb) = context {
  let w = measure(rb).width
  box(width: w)[
    #place(top + center, dy: -0.82em, text(size: 0.7em, rt))
    #rb
  ]
}

= 开发细节

Tuack-NG 不是一句#ruby[呼 #strike[Rust] 护 _Tuack-NG_][「Expecto _Tuack-NGum_!」]召唤出来的。

#figure(caption: [没错，这是 Gemini 生成的], numbering: none)[
  #image("assets/hp.png", height: 60%)
]

我们来讲讲 Tuack-NG 开发中的关键细节。

== 题面 - 一切皆 AST

什么是 AST？#strike[能吃吗？]

#pause

AST，即*抽象语法树*，是对题面（即 Markdown）的一种结构化表示，它把文本里的语法元素变成具有类型、字段和嵌套关系的节点，方便 Tuack-NG 继续处理。

#text(
  fill: gray,
)[注：与 AST 相关的概念还有具体语法树（CST），它更侧重保留具体语法结构。Tuack-NG 使用的是 AST，感兴趣的可以自行了解 CST。]


// ---------------------------------------------------------------- 题面 - AST
// 左 = Markdown 原文，右 = 解析出的 AST；同一种元素一种颜色，不追求对齐
// 左栏字号固定 11pt，调用处不再逐个写 size / lh
#let src-hi(c, s) = band(c, s, size: 11pt, lh: 14pt)
#let src-tx(s) = mono(s, size: 11pt)

#let m-md = (
  src-hi(m1, "$1 \\leq n \\leq 10^5$") + src-hi(m10, "，") + src-hi(m1, "$r_i \\leq 2$"),
  [],
  src-hi(m2, "$$"),
  src-hi(m2, "\\sum_{i=1}^{n} r_i \\leq 10^{18}"),
  src-hi(m2, "$$"),
  [],
  src-hi(m3, "![")
    + src-hi(m4, "示例图片")
    + src-hi(m3, "](")
    + src-hi(m5, "img/demo.png")
    + src-hi(m3, ")")
    + src-hi(m11, "{")
    + src-hi(m6, "width=40%")
    + src-hi(m11, "}"),
  [],
  src-hi(m7, ":::") + src-hi(m14, "figure") + src-hi(m13, "{") + src-hi(m8, "caption=\"看我！\"") + src-hi(m13, "}"),
  src-hi(m10, "这是") + src-hi(m12, "*居中*") + src-hi(m10, "文字！"),
  src-hi(m7, ":::"),
)

// 右栏：公共基础缩进（不上色）+ 每个嵌套层 3 空格，用该层节点的颜色
// 每深一层 4 格：该层父节点有颜色就用色条，没有就留空格（none）
// 色条圆角、无左右内边距
#let gut(..cs) = (
  mono("    ")
    + cs
      .pos()
      .map(c => if c == none {
        mono("    ")
      } else {
        band(c, "    ", inset: 0pt, radius: 0.25em)
      })
      .join()
)

#let m-ast = (
  mono("Document { blocks: ["),
  gut() + mono("Paragraph(["),
  gut(none) + band(m1, "Latex(\"1 \\\\leq n \\\\leq 10^5\"),"),
  gut(none) + band(m10, "Text(\"，\"),"),
  gut(none) + band(m1, "Latex(\"r_i \\\\leq 2\")"),
  gut() + mono("]),"),
  gut() + band(m2, "LatexBlock(\"\\\\sum_{i=1}^{n} r_i \\\\leq 10^{18}\\n\"),"),
  gut() + mono("Paragraph(["),
  gut(none) + band(m3, "Image(Image {"),
  gut(none, m3) + band(m5, "destination: \"img/demo.png\","),
  gut(none, m3) + band(m3, "title: None,"),
  gut(none, m3) + band(m4, "alt: \"示例图片\","),
  gut(none, m3) + band(m11, "attr: Some(ImageAttributes {"),
  gut(none, m3, m11) + band(m6, "width: Some(\"40%\"),"),
  gut(none, m3, m11) + band(m11, "height: None,"),
  gut(none, m3) + band(m11, "}),"),
  gut(none) + band(m3, "}),"),
  gut() + mono("]),"),
  gut() + band(m7, "Container(Container {"),
  gut(m7) + band(m7, "kind: ") + band(m14, "\"figure\","),
  gut(m7) + band(m13, "params: [") + band(m8, "KeyValue(\"caption\", \"看我！\")") + band(m13, "],"),
  gut(m7) + band(m7, "blocks: ["),
  gut(m7, m7) + mono("Paragraph(["),
  gut(m7, m7, none)
    + band(m10, "Text(\"这是\")")
    + mono(", ")
    + band(m12, "Emphasis([Text(\"居中\")])")
    + mono(", ")
    + band(m10, "Text(\"文字！\"),"),
  gut(m7, m7) + mono("]),"),
  gut(m7) + band(m7, "],"),
  gut() + band(m7, "}),"),
  mono("] }"),
)

---

#grid(
  columns: (1fr, 1.35fr),
  column-gutter: 20pt,
  align: top,
  [
    #align(center)[原文]
    #mcol(m-md, size: 11pt, lh: 14pt)
    #text(fill: gray, size: 14pt)[为了在 PPT 内放下，AST 中的 Span 信息被删除了，不过这不影响理解。]
  ],
  [
    #align(center)[AST]
    #mcol(m-ast)
  ],
)

---

Tuack-NG 对题面的处理与转换，主要通过操作 AST 完成。

#v(6pt)
#text(size: 13pt)[
  #diagram(
    node-stroke: 0.7pt,
    node-corner-radius: 4pt,
    node-inset: 5pt,
    edge-stroke: 1pt,
    spacing: (40pt, 30pt),
    {
      // 题面源、AST 与规则检查
      node(name: <source>, (0, 0), [题面源])

      node(
        name: <ast>,
        (1, 0),
        [*AST*],
        stroke: 1.4pt,
        fill: rgb("#eaf2fb"),
      )

      node(
        name: <doc>,
        (1, -1.5),
        [`doc check` / `doc format`

          根据规则检查 / 修改 AST],
        stroke: none,
        fill: none,
      )

      // 处理器列表
      let processors = (
        (
          name: <loj>,
          body: [
            `loj_table`

            将表格改写成 LOJ 兼容格式
          ],
        ),
        (
          name: <htm>,
          body: [
            `html_table`

            将表格改写为 HTML
          ],
        ),
        (
          name: <uoj>,
          body: [
            `uoj_title`

            UOJ 兼容：每个标题层级加一
          ],
        ),
        (
          name: <plg>,
          body: [
            插件注册的处理器

            任意操作
          ],
        ),
      )

      // 处理器节点围绕 y = 0 对称排列
      // 步长必须取整数：Fletcher 的网格行距按行算，落在非整数坐标上间距会不匀
      let proc-step = 1
      let proc-first-y = (
        -(
          (processors.len() - 1) / 2
        )
          * proc-step
      )

      node(
        (2, proc-first-y - 1),
        [*处理器*],
        stroke: none,
        fill: none,
      )

      for (i, proc) in processors.enumerate() {
        let y = (
          (
            i - (processors.len() - 1) / 2
          )
            * proc-step
        )

        node(
          (2, y),
          proc.body,
          name: proc.name,
          fill: rgb("#fdf0f0"),
          height: 53pt,
        )
      }

      // 将所有处理器包进同一个分组
      node(
        enclose: (<loj>, <htm>, <uoj>, <plg>),
        name: <procs>,
        stroke: 1.2pt + rgb("#e8a4a4"),
        fill: rgb("#fef7f7"),
        inset: 10pt,
      )

      // 处理后的 AST
      node(
        name: <ast-m>,
        (3, 0),
        [*AST'*],
        stroke: 1.4pt,
        fill: rgb("#eaf2fb"),
      )

      // 打印器列表
      let printers = (
        (
          name: <typst>,
          body: [typst -> `.typ`],
        ),
        (
          name: <md>,
          body: [markdown -> `.md`],
        ),
        (
          name: <plug-printer>,
          body: [插件 -> `.<?>`],
        ),
      )

      // 打印器节点围绕 y = 0 对称排列
      let printer-step = 1
      let printer-first-y = (
        -(
          (printers.len() - 1) / 2
        )
          * printer-step
      )

      node(
        (4, printer-first-y - 0.6),
        [*打印器*],
        stroke: none,
        fill: none,
      )

      for (i, printer) in printers.enumerate() {
        let y = (
          (
            i - (printers.len() - 1) / 2
          )
            * printer-step
        )

        node(
          (4, y),
          printer.body,
          name: printer.name,
          fill: rgb("#eef6ee"),
          height: 34pt,
        )
      }

      // 连线
      edge(
        <source.east>,
        <ast.west>,
        [`parse()`],
        "->",
        label-pos: 0.5,
      )

      edge(
        <doc.south>,
        <ast.north>,
        "<->",
        stroke: 0.6pt,
      )

      edge(<ast.east>, <procs.west>, "->")
      edge(<procs.east>, <ast-m.west>, "->")

      edge(<ast-m.east>, <typst.west>, "->")
      edge(<ast-m.east>, <md.west>, "->")
      edge(<ast-m.east>, <plug-printer.west>, "->")
    },
  )
]

== 未细调

#align(center)[
  #line(length: 55%, stroke: 0.8pt + gray)
  #v(12pt)
  #text(size: 18pt, fill: gray)[以下幻灯片尚未细调]

  #text(size: 18pt, fill: color.red)[可能包括不完整，错误，AI slop 的内容]

  #text(size: 18pt, fill: color.yellow)[请在完成前清空以下内容]
  #v(12pt)
  #line(length: 55%, stroke: 0.8pt + gray)
]

== 插件

插件用来扩展 Tuack-NG 的渲染、导出和题面能力。装好之后，它和内置目标用法一样：在 `ren` / `dump` 里直接写名字。

#grid(
  columns: (1.05fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #text(size: 15pt, weight: "bold")[插件能加什么]
    #v(4pt)
    #code(size: 12pt)[
      ```txt
      渲染目标    tuack-ng ren <名字>
      导出目标    tuack-ng dump <名字>
      命令        新的子命令
      资源        模板、字体
      ```
    ]
    #v(6pt)
    `ren --list` 和 `dump --list` 列出当前全部可用名字，内置的和插件的都在里面。
  ],
  [
    #text(size: 15pt, weight: "bold")[怎么装]
    #v(4pt)
    #code(size: 12pt)[
      ```txt
      tuack-ng plugin market install <name>
      tuack-ng plugin list
      tuack-ng plugin trust <name>
      ```
    ]
    #v(6pt)
    市场在 `tuack-ng/tuack-ng-plugins`。刚装上是未信任状态，不加载；更新后取消信任，需要重新确认。
  ],
)

== 架构

源码分四块。插件能挂进流程，是因为插件和内置实现用的是同一套 trait。

#grid(
  columns: (1fr, 1.45fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(size: 12pt)[
      ```txt
      tuack-ng          命令行
      tuack-lib         契约：类型与 trait
      tuack-utils       内置实现：导出器、渲染
      tuack-plugin-sdk  插件作者的 SDK
      ```
    ]
  ],
  [
    #code(size: 12pt)[
      ```rust
      // tuack-plugin-sdk 里的渲染器契约
      pub trait Renderer: Send + Sync {
          fn new() -> Self where Self: Sized;
          fn render(&self, doc: RenderDocument)
              -> Result<(PathBuf, Vec<OutputFile>), Error>;
      }

      // 实现 trait，再调一个宏注册成 extism 导出函数
      renderer!(MyRenderer);
      ```
    ]
  ],
)


== 前后端分离

题面源和输出目标分开，导出是同一套路。前端只管写出内容，后端决定它长什么样。

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #text(size: 15pt, weight: "bold")[题面]
    #v(4pt)
    #code(size: 12pt)[
      ```txt
      一份 statement.md
            ↓
      NOI ／ CCPC ／ Markdown
      ```
    ]
    #v(6pt)
    换目标不用动题面。前面那页三种渲染结果就是从同一份源出来的，因为中间那棵 AST 是共用的。
  ],
  [
    #text(size: 15pt, weight: "bold")[导出]
    #v(4pt)
    #code(size: 12pt)[
      ```txt
      一份 conf.json
            ↓
      Lemon ／ Arbiter ／ CCR-Plus
      ```
    ]
    #v(6pt)
    打印器、导出器都是可插拔的后端，插件挂的就是这里；一个后端出问题，不影响别的目标。
  ],
)

== 插件 - WASM

插件编译成 WASM 模块，宿主用 Extism 加载。

#grid(
  columns: (1.15fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #text(size: 15pt, weight: "bold")[边界只走数据]
    #v(4pt)
    #code(size: 12pt)[
      ```txt
      宿主 (tuack-ng)                插件 (wasm)

        render(RenderDocument)  ──▶
        ◀── 主产物路径 + OutputFile 列表
      ```
    ]
    #v(6pt)
    跨 extism 边界只传可序列化的数据与可恢复的错误；`Renderer`、`Dumper` 这些 host 侧 trait 留在各自模块，不出门。
  ],
  [
    #text(size: 15pt, weight: "bold")[大文件不进 WASM]
    #v(4pt)
    插件声明 `wasi` 时，宿主把临时目录挂成插件里的 `/`，产物落在 `/out`。数据文件不走 WASM，由宿主两边直接对接——几十 MB 的 `1.in` 不会被塞进插件内存。
  ],
)
