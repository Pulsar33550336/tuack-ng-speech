#import "@preview/xwysyy:0.4.0": *
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/fletcher:0.5.8": diagram, edge, node
#show: show-cn-fakebold

#import "assets/icon.typ": tuack-icon

#show: xwysyy-pre.with(
  theme: "sky",
  font: "LXGW WenKai",
  heading-font: "LXGW WenKai",
  code-font: "Maple Mono Normal NL NF",
  lang: "zh",
  config-info(
    title: [#box(tuack-icon(ink: white, size: 2em))\ Tuack-NG],
    subtitle: [功能 & 设计分享],
    author: "Pulsar2021",
    date: datetime(year: 2026, month: 10, day: 13),
    institution: "MS Attached to NWPU",
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

#import "assets/style.typ": *

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

#image("assets/前言/image2.png")

#pause

#image("assets/前言/image.png")

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

#v(10pt)

这次讲演，我将尝试讲解：Tuack-NG 可以解决哪些问题。

= 功能一览

#script[
  说了这么多痛点，那 Tuack-NG 到底能做什么？

  它想管的是出一道题的整个流程，大致分三块：题面、数据与测试、导出。下面我们按这个顺序过一遍。
]
// 约 70 字

说了这么多，Tuack-NG 可以做什么呢？

#sep

Tuack-NG 开发时的主要目标便是辅助题目相关的所有环节，主要涵盖：

- *题面*：书写与生成美观的 PDF/导出到 OJ；
- *数据与测试*：造 & 校验数据，测试测试用例；
- *导出*：将评测资源导出到评测平台。

== 题面 - 语法

#script[
  题面用 Markdown 写，CNOI 那套语法全都实现了：表格合并、图片属性、公式、容器、脚注，还有 GFM。

  等等，GFM 是什么？它是 GitHub 对 Markdown 的超集，大家常用的表格与删除线就脱胎于它。
]
// 约 100 字（含下一页对比图）

Tuack-NG 使用 Markdown 编写题面，并且支持*完整的 CNOI 拓展语法*。

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
  table.cell(colspan: 2, align: left)[……以及一些额外语法：],
  [*对齐*], [`:::align{right}`],
)



#{
  set align(top)
  script[
    左边那段题面渲染出来就是右边的样子，而使用 CNOI 与 Tuack-NG 的渲染成果完全一致。
  ]
  compare-slide(
    title: [题面 - 语法],
    left: card[
      #align(center)[#text(size: 14pt)[*题面源码*]]
      #set text(size: 11pt)
      #raw(read("assets/功能一览/题面-语法/cnoi-syntax.md"), lang: "md")
    ],
    right: card[
      #align(center)[#text(size: 14pt)[*渲染结果*]]
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 10pt,
        align(center)[
          #image("assets/功能一览/题面-语法/cnoi-syntax.png", height: 235pt)
          #text(size: 15pt)[Tuack-NG]
        ],
        align(center)[
          #image("assets/功能一览/题面-语法/cnoi-syntax-cnoi.png", height: 235pt)
          #text(size: 15pt)[CNOI]
        ],
      )
    ],
  )
}

// 左 = statement.md 原文，右 = 同一段展开之后；一对「模板 ↔ 展开」一种颜色

== 题面 - 语法 - 模板系统

#script[
  模板系统是我觉得比较有价值的一块，它使得题面里可以直接写模板表达式。

  如果有人想了解的话，模板系统是基于 MiniJinja 的，它支持非常多写法，远不止幻灯片里展示的效果。

  幻灯片里的，就是使用模板系统展开的一个例子，其中对应颜色的就是展开内容。输入输出文件名、测试点数量、样例内容，全从配置里取，不用手抄一遍，不仅减少了重复工作，还避免了多处修改时可能出现的疏漏。
]
// 约 180 字

Tuack-NG 还支持更强大的*模板系统*。

#import "assets/功能一览/题面-语法-模板系统/template-system.typ": m-left, m-right

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


== 题面 - 语法 - 外置表格

#script[
  模板好用，但拿它生成表格就变成这一坨。这是我暑假时遇到的实际情况，正是这个问题启发了我开发 Lua 表格。
]
// 约 51 字

手写的表会过时，那就用模板自动生成——可题面里就变成了一坨。

#v(4pt)
#import "assets/功能一览/题面-语法-外置表格/external-table.typ": tbl-jinja

#cblock(tbl-jinja, size: 16pt, leading: 0.55em, hl: 6, note: "PS：高亮内容是一行 🤡")

---

#script[
  同一张表可以搬出题面，写成一个 Lua 文件：表头、数据来源、每一列的合并规则都在这里声明清楚。

  题面里不会再有循环和判断，改表也不用碰题面，并且更加明了。
]
// 约 75 字

同一张表，换成一个 Lua 文件。

#v(4pt)
#code(raw(read("assets/功能一览/题面-语法-外置表格/table-merge.lua"), lang: "lua", block: true), size: 12.5pt)

== 题面 - 渲染

#script[
  题面可以被渲染到各种目标：NOI、CCPC、Markdown……

  上面两张就是同一道题分别按 NOI 和 CCPC 的样式渲染出来的封面。
]
// 约 64 字

// 同一份 `statement.md`，`ren` 一下换一套版面——连同封面。

Tuack-NG 支持多种渲染目标，包括但不限于 (C)NOI、CCPC 与 Markdown，且*可拓展*。

#v(6pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 26pt,
  align: (center + top, center + top),
  [
    #text(size: 22pt)[NOI]
    #image("assets/功能一览/题面-渲染/cover-noi-top.png", width: 100%)
  ],
  [
    #text(size: 22pt)[CCPC]
    #image("assets/功能一览/题面-渲染/cover-ccpc-top.png", width: 100%)
  ],
)

---

#script[
  不同平台的 Markdown 语法是不同的：比如，LOJ 和 Hydro 会自动合并相邻的相同单元格，而 UOJ 不认识表格语法。

  因此，Tuack-NG 有多个特化的 Markdown 导出目标。同时，插件可以设置自己的特化逻辑，这个一会会讲。
]
// 约 112 字

Tuack-NG 的 Markdown 导出目标还可以针对目标进行调整，比如标题层级、表格等。

#v(-12pt)

#import "assets/功能一览/题面-渲染/render-targets.typ": MD-CODE, MD-LH, md-head, md-loj, md-plain, md-uoj

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

#script[
  然后说数据。

  这是很多人包括我之前的写法：把文件名和参数写死在源码里，每跑一次改一次；或者像右边，把参数列进数组，但种子是 `time(0)`，跑出来不可复现。

  就算把种子固定住，往数组中间插一个点，或者改一个种子，所有数据都得重造。
]
// 约 114 字

#v(4pt)
#grid(
  columns: (0.6fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    很多人是这么造数据的：
    #code(raw(read("assets/功能一览/数据与测试/gen-naive.cpp"), lang: "cpp", block: true), size: 14pt)
    但参数和文件名写死在源码里，每跑一次就得改一次。
  ],
  [
    聪明些的写法：
    #code(raw(read("assets/功能一览/数据与测试/gen-array.cpp"), lang: "cpp", block: true), size: 14pt)
    但*不可复现*：种子是 `time(0)`；就算种子固定，*改一个也得全部重造*——数组里插一个点，它后面所有点的随机序列都跟着变了。
  ],
)

== 数据与测试 - 生成器

#script[
  Tuack-NG 里，生成器里只剩一件事：把参数变成数据。

  文件名、第几个测试点、种子，都不用你管。参数写在配置里，运行时 Tuack-NG 传进来，生成的数据打到标准输出，剩下的写盘和编号全归 Tuack-NG。
]
// 约 102 字

与 Tuack-NG 集成时，生成器里不需要文件名、不需要「第几个测试点」，也不用自己生成和保存种子——只剩「把参数变成数据」这一件事。

#grid(
  columns: (0.75fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(raw(read("assets/功能一览/数据与测试/gen-testlib.cpp"), lang: "cpp", block: true), size: 14pt)
  ],
  [
    参数从配置里来：
    #v(-8pt)
    #code(raw(read("assets/功能一览/数据与测试/gen-args.json"), lang: "json", block: true), size: 14pt)
    #v(-8pt)
    然后，生成器会被传入 `-n=2 -m=20 -seed=<...>`。
  ],
)

你只需要接收参数，将生成的数据打印到标准输出，剩下的全归 Tuack-NG 管。

== 数据与测试 - 生成器 - 种子

#script[
  种子也不用操心：Tuack-NG 按测试点生成一份，存在数据目录里，生成器那边只要一行代码把种子设置好就行。

  所以，同样的配置与种子，在不同时间，不同机器上，只要实现固定，生成出来的还是同一份数据。
]
// 约 97 字

随机数种子不用你操心：Tuack-NG 给*每个测试点*生成一份，记在 `data/.seed` 里。

#v(6pt)
#grid(
  columns: (1fr, 1.15fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(raw(read("assets/功能一览/数据与测试/seed.json"), lang: "json", block: true), size: 16pt)
  ],
  [
    #set align(horizon)
    Tuack-NG 也提供了操控种子重新生成的方法；
    生成器那边只需要一行 `rnd.setSeed(seed)`，而种子由 Tuack-NG 传进来。
  ],
)

#line(length: 100%, stroke: gray)

同样的 `args` 加同样的 `seed`，*换时间、换机器，出来的还是同一份数据*。

== 数据与测试 - 测试

#script[
  相信不少出过题的，都放过过一些错解。没出过题的，大概也写过一些骗分代码——比如说「不可以，总司令」。

  当然，作为出题人，我们还是不希望错解通过的。在 Tuack-NG 中，你可以把错解写进配置，然后在日后的测试中，Tuack-NG 就可以帮你检查它有没有获得不应该的分数。

  当然，测试的前提是正确配置测试。不过这不成问题：Tuack-NG 支持子任务与捆绑测试，还有 Special Judge 与 NOI 风格的交互题。
]
// 约 200 字

想卡掉的错解，赛时才发现 AC 了？

在筹备阶段，把「它该得几分」提前写进配置，Tuack-NG 会帮你检查它在数据上的运行结果是否符合你的预期。

#grid(
  columns: (1.15fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(raw(read("assets/功能一览/数据与测试/tests.json"), lang: "json", block: true), size: 16pt)
  ],
  [
    #set align(horizon)

    期望分数写成表达式（`== 100`、`>= 10`），也可以给区间，满足各种需求。

    支持子任务（捆绑测试）与 SPJ。
  ],
)

== 数据与测试 - 校验

#script[
  相信大家都有遇到过错误数据的经历，比如我遇到过零分之一，以及之前的模拟赛还出现过格式错误的样例。

  如果样例或者小数据造错了，可以肉眼看出来；但大数据与极端数据，凡胎肉身可看不完。

  作为 OIer，大家应该对 Validator 不陌生；如果有不了解的同学，Validator 就是校验数据是否符合格式与限制的程序。

  Tuack-NG 同样支持接入 Validator 来校验数据，甚至支持在生成数据的同时校验。

  说句闲话：Big Mike 的 Testlib 为什么不支持在 Validator 里接收参数啊？
]
// 约 238 字

零分之一、树上造了个环？小数据可以自己盯，但动辄数 MB 的大数据怎么看？

让我们写个 Validator 让程序去看。

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(raw(read("assets/功能一览/数据与测试/val.cpp"), lang: "cpp", block: true), size: 16pt)
  ],
  [
    #code(raw(read("assets/功能一览/数据与测试/validator.json"), lang: "json", block: true), size: 16pt)
    同时，我们支持在生成数据时顺手校验，从源头解决问题。
  ],
)
#text(fill: gray)[碎碎念：Testlib 不支持在 Validator 里使用 `opt` 接收参数，TAT……]

== 导出

#script[
  数据造完了，最后是导出到评测平台。

  每个平台的目录结构都不一样：Lemon 一套、Arbiter 一套、CCR-Plus 又是另一套，并且手配的话很麻烦。

  Tuack-NG 可以帮你把这套事情处理好。
]
// 约 110 字

Lemon 一套、Arbiter 一套，CCR-Plus 一套……BOOM，换个评测平台就得把数据重新手配一遍。

#v(4pt)

Tuack-NG 帮你导出到评测平台。

#v(6pt)
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 18pt,
  align: top,
  [
    #align(center)[Lemon]

    #code(raw(read("assets/功能一览/导出/dump-lemon.txt"), lang: "txt", block: true), size: 12pt)
  ],
  [
    #align(center)[Arbiter]

    #code(raw(read("assets/功能一览/导出/dump-arbiter.txt"), lang: "txt", block: true), size: 12pt)
  ],
  [
    #align(center)[CCR-Plus]

    #code(raw(read("assets/功能一览/导出/dump-ccr-plus.txt"), lang: "txt", block: true), size: 12pt)
  ],
)

== 小功能

#script[
  再说两个顺手的小功能。

  左边是题面查错。中英文之间该不该空格、标点用全角还是半角、公式前后有没有空格，这些规范人眼容易漏；`doc check` 会照规则找出来，能改的 `doc format` 直接改掉。

  右边是批量改配置：在比赛或者比赛日这一层跑一条命令，底下的题目一起改，不用一个个文件动。
]
// 约 141 字

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
    #code(raw(read("assets/功能一览/小功能/conf-cmds.txt"), lang: "txt", block: true), size: 14pt)
    #v(8pt)
    在比赛日或比赛层级执行，一次改掉下面所有题目。
  ],
)

== 插件

#script[
  插件能给 Tuack-NG 加什么？大概五类。

  处理器在组装渲染文档的途中改 AST；渲染器提供新的渲染实现；模板增加一个渲染目标；导出器增加一个导出目标；资源则是随插件一起带的模板、字体这类文件。

  具体怎么跑起来、怎么保证安全，放到后面的「开发细节」讲。
]
// 约 123 字

插件可以拓展 Tuack-NG 的功能。

#v(8pt)
- *处理器*：在 `ren` 组装渲染文档的途中改写 AST；
- *渲染器*：提供新的渲染实现；
- *模板*：增加一个渲染目标；
- *导出器*：增加一个导出目标；
- *资源*：随插件携带模板、字体等文件。


= 开发细节

#script[
  功能就讲到这里，下面说设计。

  先声明：Tuack-NG 不是念句咒语变出来的——上面这张图显然是 Gemini 生成的。当然，代码里没有魔法，下面挑几个关键的地方讲。
]
// 约 79 字

Tuack-NG 不是一句#ruby[呼 #strike[Rust] 护 _Tuack-NG_][「Expecto _Tuack-NGum_!」]召唤出来的。

#figure(caption: [这张图显然是 Gemini 生成的], numbering: none)[
  #image("assets/开发细节/hp.png", height: 60%)
]

我们来讲讲 Tuack-NG 开发中的关键细节。

== 题面 - 一切皆 AST

#script[
  先讲第一个细节：AST。

  什么是 AST？
]
// 约 19 字

什么是 AST？#uncover("1")[#strike[能吃吗？]]

#pause

#script[
  显然不能吃。

  AST 是抽象语法树，是题面的一种结构化表示：把文本里的语法元素变成有类型、有字段、能嵌套的节点，后面的处理都在它上面做。

  顺便提一句，还有个概念叫具体语法树，也就是 CST，它更强调保留原本的语法结构。Tuack-NG 用的是 AST，感兴趣的可以自己查。
]
// 约 130 字

AST，即*抽象语法树*，是对题面（即 Markdown）的一种结构化表示，它把文本里的语法元素变成具有类型、字段和嵌套关系的节点，方便 Tuack-NG 继续处理。

#text(
  fill: gray,
)[注：与 AST 相关的概念还有具体语法树（CST），它更侧重保留具体语法结构。Tuack-NG 使用的是 AST，感兴趣的可以自行了解 CST。]

// 左 = Markdown 原文，右 = 解析出的 AST；同一种元素一种颜色，不追求对齐

---

#script[
  左边这段题面，解析出来就是右边这棵树。同一种元素同一种颜色：公式变 Latex，图片变 Image，容器变 Container，正文就是 Text。

  这里我把每个节点的 Span 信息删掉了，不然放不下——Span 记录这个节点在原文里的位置，报错和格式化都靠它。
]
// 约 124 字

#import "assets/开发细节/题面-一切皆AST/ast-compare.typ": m-ast, m-md

#grid(
  columns: (1fr, 1.35fr),
  column-gutter: 20pt,
  align: top,
  [
    #align(center)[原文]
    #mcol(m-md, size: 11pt, lh: 14pt)
    #text(fill: gray, size: 14pt)[为了在幻灯片内放下，AST 中的 Span 信息被删除了，不过这不影响理解。]
  ],
  [
    #align(center)[AST]
    #mcol(m-ast)
  ],
)

---

#script[
  整条链路是这样：题面源过一遍 `parse` 变成 AST，然后交给一串处理器。`loj_table` 把表格改成 LOJ 兼容格式，`html_table` 改成 HTML，`uoj_title` 把标题层级加一——插件注册的处理器也挂在这一层。

  处理完的 AST 交给打印器，出来就是 Typst 或者 Markdown。题面查错的 `doc check` 和 `doc format`，也是在这一层的 AST 上做的。
]
// 约 190 字

Tuack-NG 对题面的处理与转换，主要通过操作 AST 完成。

#include "assets/开发细节/题面-一切皆AST/ast-pipeline.typ"

== 前后端分离

#script[
  再讲一个我觉得比较重要的设计：前后端分离。

  跟文件系统、操作系统打交道的部分留在前端，与它们无关的后端逻辑单独成层。这张图就是各个功能用到的后端抽象：蓝色是结构体，红色是 trait，绿色是产物。

  拿渲染这一行举例：`Document` 先交给 `RenProcessor` 改写，再交给 `Renderer` 渲染出题面。这些 trait，就是插件和别的前端能接进来的地方。
]
// 约 179 字

Tuack-NG 做了前后端分离。\
将与文件系统 / 操作系统无关的后端从前端分离出来，从而让 Tuack-NG 更容易被拓展。

#include "assets/开发细节/前后端分离/chains.typ"

== 前后端分离 - 实现

#script[
  实现上是几个 crate 加一个契约层。

  最上面是宿主 `tuack-ng`：编排流程、组装 trait 对象、处理交互和文件 I/O，边上 `tuack-config` 管配置。内置实现都放在 `tuack-utils`，挂在宿主下面。

  中间的 `tuack-lib` 定义 trait 和跨边界的数据，自己不干活：宿主用它，utils 实现它，`tuack-ng-parser` 给它提供 AST 能力，插件通过 `tuack-plugin-sdk` 对接同一套契约。
]
// 约 215 字

#v(4pt)
#include "assets/开发细节/前后端分离/roles.typ"

== 前后端分离 - 实际成果

#script[
  分离出来之后，很快就有东西用上了。

  第一是 RPC：`rpc` 分支上正在开发一个基于 JSON-RPC 2.0 的服务端，把后端能力暴露出去。第二是 Tuack-GUI，图形化前端，目前是对命令行的封装，RPC 通路正在接入。第三是 Tuack for VS Code，基于 RPC，还在 WIP。

  后两个的仓库二维码在下面，感兴趣可以扫。
]
// 约 156 字

#grid(
  columns: (0.5fr, 1fr, 1fr),
  column-gutter: 16pt,
  align: top,
  [
    #align(center)[#text(size: 18pt)[*RPC*]]
    #v(2pt)
    Tuack-NG `rpc` 分支上正在开发的、基于 JSON-RPC 2.0 的 RPC 服务端。
  ],
  [
    #align(center)[#text(size: 18pt)[*Tuack-GUI*]]
    #v(2pt)
    Tuack-NG 的图形化前端。

    目前是对命令行的封装，基于 RPC 的逻辑正在接入。
  ],
  [
    #align(center)[#text(size: 18pt)[*Tuack for VS Code*]]
    #v(2pt)
    Tuack-NG 的 VS Code 图形化前端，基于 RPC。WIP。
  ],
)
#v(-18pt)
#grid(
  columns: (0.5fr, 1fr, 1fr),
  column-gutter: 16pt,
  [],
  [
    #align(center)[
      #figure(caption: "https://github.com/tuackng/Tuack-GUI", numbering: none)[
        #image("assets/致谢-查看更多/qr-gui.png", height: 40%)
      ]
    ]
  ],
  [
    #align(center)[
      #figure(caption: "https://github.com/Qaaxaap/tuack-vscode", numbering: none)[
        #image("assets/致谢-查看更多/qr-vscode.png", height: 40%)
      ]
    ]
  ],
)


== 插件

#script[
  最后一块：插件。

  插件是 Tuack-NG 的主要扩展方式，方案是 WASM 运行时加 Extism——一个通用的插件系统 SDK。为什么选 WASM？下一页。
]
// 约 72 字

Tuack-NG 的插件基于 WASM 运行时与 Extism（一个插件系统的 SDK 库）。

== 插件 - Why WASM?

#script[
  四个理由。

  第一，Rust 没有稳定的 ABI。动态加载代码要靠 ABI，而 Rust 不提供，插件换个编译器版本或者换个平台，就可能把主程序拖崩。

  第二，原生二进制跨平台不兼容：Windows 要 `.dll`、Linux 要 `.so`、macOS 要 `.dylib`，每多一个平台就多一份编译和分发工作。

  第三，安全性——WASM 跑在沙箱里，权限能逐项控制。

  第四，同质性：插件可以用和主程序同一种语言写，不用再维护一套别的语言的 API。
]
// 约 208 字

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  row-gutter: 40pt,
  align: top,
  [
    *Rust 没有稳定的 ABI*

    ABI 全称「应用二进制接口」——程序想动态加载代码就得靠它，这是插件的基础。Rust 不提供稳定的 ABI，插件一旦编译器版本或平台不同，就可能把 Tuack-NG 拖崩。
  ],
  [
    *二进制库文件跨平台不兼容*

    作者得为 Windows 编 `.dll`、为 Linux 编 `.so`、为 macOS 编 `.dylib`……每多一个平台就多一份编译与分发工作。
  ],

  [
    *安全性*

    WASM 跑在沙箱里，权限能逐项控制，可以防住危险插件引发的安全问题。
  ],
  [
    *同质性*

    插件可以用和主程序同一种语言写：不必维护另一套语言的 API，插件作者的负担也小。
  ],
)

== 插件 - Plugin SDK

#script[
  Extism 是通用的跨语言插件 SDK，但它只管到函数：声明导出函数、按名字调用、参数和返回值走序列化。再往下就不管了，写插件的人得先学跨边界，而不是写业务。

  所以有了 `tuack-plugin-sdk`。左边这段就是一个完整的处理器插件：实现 `process`，最后用 `processor!` 导出。跨 Extism 和主程序的边界，全交给 SDK。

  而且插件实现某个功能的方式跟主程序几乎一样，写插件可以直接参考主程序的代码。
]
// 约 208 字

Extism 是通用的跨语言插件 SDK，它只能管到*函数*：声明导出函数、按名字调用、参数与返回值走序列化。再往下就不管了——写插件的人被迫先学会跨边界，而不是写业务。


#grid(
  columns: (1.75fr, 1fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(raw(read("assets/开发细节/插件-WASM/sdk-plugin.rs"), lang: "rust", block: true), size: 14pt)
  ],
  [
    #set align(horizon)

    所以有了 `tuack-plugin-sdk`：插件作者只管实现业务，所有跨 Extism 与主程序的边界交给它。

    并且，插件实现某个功能的方式与主程序几乎一致，写插件时可以直接参考主程序的代码。
  ],
)

== 插件 - 信任模型

#script[
  插件是别人的代码，WASM 产物又几乎没法审计，所以得有信任模型。

  安装之后插件处于「未信任」，不加载。它得先公开自己超出默认值的能力——比如访问文件、执行「某些」命令——用户手动确认之后，才变成「已加载」。取消信任、或者插件更新，都会退回去。

  另外，插件市场不允许闭源插件，构建产物也必须来自 CI。这两条已经在执行，只是还没成文。CI 就是让机器按写好的工作流构建，排除人工插手的可能。
]
// 约 190 字

插件是别人的代码，WASM 几乎不可审计。因此，插件需要公开它超出默认值的能力（比如，访问文件，执行「某些」命令），并由用户手动确认并信任。

#v(2pt)
#include "assets/开发细节/插件-信任模型/trust-flow.typ"
#v(2pt)

同时，*Tuack-NG 的插件市场不允许闭源插件，构建产物也必须来自 CI（持续集成）*，以保证安全性（这两条已经执行，但尚未成文）。

#text(fill: gray)[CI（持续集成）：具体地说，就是在 GitHub 提供的机器上使用写好的工作流构建插件，以排除人工插手的可能。]

#touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(fill: skyl))
  touying-slide(self: self, [
    #v(-50pt)
    #align(center)[#text(size: 36pt, fill: sea, font: "Noto Serif")[_Thanks for Watching!_]]
    #grid(
      columns: (0.4fr, 1fr),
      column-gutter: 26pt,
      align: top,
      [
        #align(center)[#text(size: 22pt, weight: "bold")[声明 & 致谢]]

        #v(8pt)

        #set text(size: 16pt)

        本幻灯片在人类的监督下，使用 DeepSeek V4.1 Flash（搭配 DeepSeek Harness），并经过人类辅助制作，基于 Typst、Touying 与 xwysyy 模板排版，保证人类的贡献大于 LLM。

        在制作过程中，我：

        - 参考了 ChatGPT（5.6-Luna & 6）的建议；
        - 向大家发布了问卷，也与一些同学进行了交流。

        在此一并感谢！

      ],
      [
        #align(center)[#text(size: 22pt, weight: "bold")[查看更多]]

        #v(2pt)
        #grid(
          columns: (1fr, 1.1fr),
          column-gutter: 12pt,
          row-gutter: 6pt,
          [#grid(
            columns: (auto, 1fr),
            column-gutter: 12pt,
            row-gutter: 8pt,
            align: horizon,
            [#image("assets/致谢-查看更多/qr-tuack-ng.png", height: 44pt)],
            [*项目仓库*\ #text(size: 13pt)[`github.com/tuackng/tuack-ng`]],

            [#image("assets/致谢-查看更多/qr-gui.png", height: 44pt)],
            [*Tuack-GUI*\ #text(size: 13pt)[`github.com/tuackng/Tuack-GUI`]],
          )],
          [#grid(
            columns: (auto, 1fr),
            column-gutter: 12pt,
            row-gutter: 8pt,
            align: horizon,
            [#image("assets/致谢-查看更多/qr-home.png", height: 44pt)],
            [*官网（文档）*\ #text(size: 13pt)[`tuack-ng.ink`]],

            [#image("assets/致谢-查看更多/qr-vscode.png", height: 44pt)],
            [*Tuack for VS Code*\ #text(size: 13pt)[`github.com/Qaaxaap/tuack-vscode`]],
          )],
        )

        #v(2pt)

        #set text(size: 14pt)

        #align(center)[#text(size: 22pt, weight: "bold")[开源 & 许可证]]

        本幻灯片的演讲文本（包括图片）以 CC BY-SA 4.0 授权；\
        代码（包括内联在 Typst 源文件中的）以 MIT 授权。\
        由本项目或系列项目生成的文字与图片按 CC 授权，其余素材参考各自协议；\
        其中 NOIP 题面来自 CCF，以 CC BY-NC 授权。

        #grid(
          columns: (auto, 1fr),
          column-gutter: 10pt,
          align: horizon,
          [#image("assets/致谢-查看更多/qr-speech.png", height: 44pt)],
          [*幻灯片源码仓库*\ #text(size: 13pt)[`github.com/Pulsar33550336/tuack-ng-speech`]],
        )

      ],
    )
  ])
})
