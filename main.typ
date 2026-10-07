#import "@preview/xwysyy:0.4.0": *
#import "@preview/cuti:0.4.0": show-cn-fakebold
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
#let band(c, s, size: MCODE, lh: MLH) = box(
  fill: c,
  inset: (x: 0.3em),
  radius: 0.3em,
  height: 1.02 * lh,
  align(horizon, mono(s, size: size)),
)
#let m1 = rgb("#9ec9f5") // input_file
#let m2 = rgb("#ffd166") // data | length
#let m3 = rgb("#9ee493") // tools.cases
#let m4 = rgb("#f7a8c4") // output_file
#let m5 = rgb("#c3aaf0") // sample.text
#let m6 = rgb("#7fd4cf") // sample.file

// 代码面板外观（模板系统 / 外置表格 / Markdown 导出共用）
#let panel(body, inset: (x: 10pt, y: 4pt)) = block(
  fill: skyll,
  inset: inset,
  radius: 3pt,
  width: 100%,
  body,
)

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
#let tbl-lua = (
  "local il = tng.tools.inline_latex",
  "",
  "return tng.table {",
  "    headers = { \"测试点编号\", il(\"T =\"), il(\"N \\\\le\"), il(\"\\\\lvert a_i \\\\rvert \\\\le\") },",
  "    align = { \"center\", \"center\", \"center\", \"center\" },",
  "",
  "    data = tng.config.data_cases:map(function(group)",
  "        local args = group.args",
  "        return {",
  "            tng.tools.cases(group.id),",
  "            tng.tools.inline_latex(args.T),",
  "            tng.tools.inline_latex(args.max_n),",
  "            tng.tools.inline_latex(args.max_a)",
  "        }",
  "    end),",
  "",
  "    merge_rules = {",
  "        { col = 2, merge_row = true },",
  "        { col = 3, merge_row = true },",
  "        { col = 4, merge_row = true },",
  "    },",
  "}",
)

== 题面 - 语法 - 外置表格

手写的表会过时，那就用模板自动生成——可题面里就变成了一坨。

#v(4pt)
#cblock(tbl-jinja, size: 16pt, leading: 0.55em, hl: 6, note: "PS：高亮内容是一行 🤡")

---

同一张表，换成一个 Lua 文件。

#v(4pt)
#cblock(tbl-lua, lang: "lua")

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
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    很多人是这么造数据的：
    #v(4pt)
    #cblock(
      (
        "#include <bits/stdc++.h>",
        "using namespace std;",
        "",
        "const int N = 10;",
        "const int M = 20;",
        "",
        "int main() {",
        "    freopen(\"x.in\", \"w\", stdout);",
        "    srand(time(0));",
        "    int n = rand() % N + 1;",
        "    int m = rand() % M + 1;",
        "    printf(\"%d %d\\n\", n, m);",
        "    // ...",
        "}",
      ),
      size: 12pt,
      lang: "cpp",
    )
    #v(6pt)
    但参数和文件名写死在源码里，每跑一次就得改一次。
  ],
  [
    聪明些的写法：
    #v(4pt)
    #cblock(
      (
        "#include <bits/stdc++.h>",
        "using namespace std;",
        "",
        "const int T = 6;",
        "int N[] = { 1, 2, 2, 10, 100, 100000 };",
        "long long M[] = { 10, 20, 20, 100, 1000,",
        "                  1000000000000000000LL };",
        "",
        "int main() {",
        "    srand(time(0));",
        "    for (int i = 0; i < T; ++i) {",
        "        freopen((to_string(i + 1) + \".in\").c_str(),",
        "                \"w\", stdout);",
        "        // ...",
        "    }",
        "}",
      ),
      size: 12pt,
      lang: "cpp",
    )
    #v(6pt)
    但*不可复现*：种子是 `time(0)`；就算种子固定，*改一个也得全部重造*——数组里插一个点，它后面所有点的随机序列都跟着变了。
  ],
)
