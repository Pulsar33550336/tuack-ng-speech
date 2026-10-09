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
      #raw(read("assets/Tuack-NG能做什么/题面-语法/cnoi-syntax.md"), lang: "md")
    ],
    right: card[
      #align(center)[#text(size: 14pt)[*渲染结果*]]
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 10pt,
        align(center)[
          #image("assets/Tuack-NG能做什么/题面-语法/cnoi-syntax.png", height: 235pt)
          #text(size: 15pt)[Tuack-NG]
        ],
        align(center)[
          #image("assets/Tuack-NG能做什么/题面-语法/cnoi-syntax-cnoi.png", height: 235pt)
          #text(size: 15pt)[CNOI]
        ],
      )
    ],
  )
}

// 左 = statement.md 原文，右 = 同一段展开之后；一对「模板 ↔ 展开」一种颜色

== 题面 - 语法 - 模板系统

Tuack-NG 还支持更强大的*模板系统*。

#import "assets/Tuack-NG能做什么/题面-语法-模板系统/template-system.typ": m-left, m-right

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

手写的表会过时，那就用模板自动生成——可题面里就变成了一坨。

#v(4pt)
#import "assets/Tuack-NG能做什么/题面-语法-外置表格/external-table.typ": tbl-jinja

#cblock(tbl-jinja, size: 16pt, leading: 0.55em, hl: 6, note: "PS：高亮内容是一行 🤡")

---

同一张表，换成一个 Lua 文件。

#v(4pt)
#code(raw(read("assets/Tuack-NG能做什么/题面-语法-外置表格/table-merge.lua"), lang: "lua", block: true), size: 12.5pt)

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
    #image("assets/Tuack-NG能做什么/题面-渲染/cover-noi-top.png", width: 100%)
  ],
  [
    #text(size: 22pt)[CCPC]
    #image("assets/Tuack-NG能做什么/题面-渲染/cover-ccpc-top.png", width: 100%)
  ],
)

---

Tuack-NG 的 Markdown 导出目标还可以针对目标进行调整，比如标题层级，表格等。

#v(-12pt)

#import "assets/Tuack-NG能做什么/题面-渲染/render-targets.typ": MD-CODE, MD-LH, md-head, md-loj, md-plain, md-uoj

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
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/gen-naive.cpp"), lang: "cpp", block: true), size: 14pt)
    但参数和文件名写死在源码里，每跑一次就得改一次。
  ],
  [
    聪明些的写法：
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/gen-array.cpp"), lang: "cpp", block: true), size: 14pt)
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
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/gen-testlib.cpp"), lang: "cpp", block: true), size: 14pt)
  ],
  [
    参数从配置里来：
    #v(-8pt)
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/gen-args.json"), lang: "json", block: true), size: 14pt)
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
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/seed.json"), lang: "json", block: true), size: 16pt)
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
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/tests.json"), lang: "json", block: true), size: 16pt)
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
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/val.cpp"), lang: "cpp", block: true), size: 16pt)
  ],
  [
    #code(raw(read("assets/Tuack-NG能做什么/数据与测试/validator.json"), lang: "json", block: true), size: 16pt)
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

    #code(raw(read("assets/Tuack-NG能做什么/导出/dump-lemon.txt"), lang: "txt", block: true), size: 12pt)
  ],
  [
    #align(center)[Arbiter]

    #code(raw(read("assets/Tuack-NG能做什么/导出/dump-arbiter.txt"), lang: "txt", block: true), size: 12pt)
  ],
  [
    #align(center)[CCR-Plus]

    #code(raw(read("assets/Tuack-NG能做什么/导出/dump-ccr-plus.txt"), lang: "txt", block: true), size: 12pt)
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
    #code(raw(read("assets/Tuack-NG能做什么/小功能/conf-cmds.txt"), lang: "txt", block: true), size: 14pt)
    #v(8pt)
    在比赛日或比赛层级执行，一次改掉下面所有题目。
  ],
)

== 插件

插件可以拓展 Tuack-NG 的功能。

#v(8pt)
- *处理器*：在渲染器处理题面的途中改写 AST；
- *渲染器*：增加一个渲染目标；
- *导出器*：增加一个导出目标；
- *资源*：为 Tuack-NG 贡献新模板。


= 开发细节

Tuack-NG 不是一句#ruby[呼 #strike[Rust] 护 _Tuack-NG_][「Expecto _Tuack-NGum_!」]召唤出来的。

#figure(caption: [这张图是 Gemini 生成的], numbering: none)[
  #image("assets/开发细节/hp.png", height: 60%)
]

我们来讲讲 Tuack-NG 开发中的关键细节。

== 题面 - 一切皆 AST

什么是 AST？#uncover("1")[#strike[能吃吗？]]

#pause

AST，即*抽象语法树*，是对题面（即 Markdown）的一种结构化表示，它把文本里的语法元素变成具有类型、字段和嵌套关系的节点，方便 Tuack-NG 继续处理。

#text(
  fill: gray,
)[注：与 AST 相关的概念还有具体语法树（CST），它更侧重保留具体语法结构。Tuack-NG 使用的是 AST，感兴趣的可以自行了解 CST。]

// 左 = Markdown 原文，右 = 解析出的 AST；同一种元素一种颜色，不追求对齐

---

#import "assets/开发细节/题面-一切皆AST/ast-compare.typ": m-ast, m-md

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

#include "assets/开发细节/题面-一切皆AST/ast-pipeline.typ"

== 前后端分离

Tuack-NG 做了前后端分离。\
将与文件系统 / 操作系统无关的后端分离，使得 Tuack-NG 更容易被拓展。

#include "assets/开发细节/前后端分离/chains.typ"

== 前后端分离 - 实现

#v(4pt)
#include "assets/开发细节/前后端分离/roles.typ"

== 前后端分离 - 实际成果

#grid(
  columns: (0.5fr, 1fr, 1fr),
  column-gutter: 16pt,
  align: top,
  [
    #align(center)[#text(size: 18pt)[*RPC*]]
    #v(2pt)
    Tuack-NG `rpc` 分支上，正在开发的，基于 JSON-RPC 2.0 的 RPC 服务端。
  ],
  [
    #align(center)[#text(size: 18pt)[*Tuack-GUI*]]
    #v(2pt)
    Tuack-NG 的图形化前端。

    目前基于命令行，基于 RPC 的逻辑正在接入。
  ],
  [
    #align(center)[#text(size: 18pt)[*Tuack for VS Code*]]
    #v(2pt)
    Tuack-NG 的 VSCode 图形化前端，基于 RPC。WIP。
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
        #image("assets/开发细节/前后端分离/qr-gui.png", height: 40%)
      ]
    ]
  ],
  [
    #align(center)[
      #figure(caption: "https://github.com/Qaaxaap/tuack-vscode", numbering: none)[
        #image("assets/开发细节/前后端分离/qr-vscode.png", height: 40%)
      ]
    ]
  ],
)


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

== 架构

源码分四块。插件能挂进流程，是因为插件和内置实现用的是同一套 trait。

#grid(
  columns: (1fr, 1.45fr),
  column-gutter: 20pt,
  align: top,
  [
    #code(raw(read("assets/开发细节/架构/arch-crates.txt"), lang: "txt", block: true), size: 12pt)
  ],
  [
    #code(raw(read("assets/开发细节/架构/renderer-trait.rs"), lang: "rust", block: true), size: 12pt)
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
    #code(raw(read("assets/开发细节/插件-WASM/wasm-runtime.txt"), lang: "txt", block: true), size: 12pt)
    #v(6pt)
    跨 extism 边界只传可序列化的数据与可恢复的错误；`Renderer`、`Dumper` 这些 host 侧 trait 留在各自模块，不出门。
  ],
  [
    #text(size: 15pt, weight: "bold")[大文件不进 WASM]
    #v(4pt)
    插件声明 `wasi` 时，宿主把临时目录挂成插件里的 `/`，产物落在 `/out`。数据文件不走 WASM，由宿主两边直接对接——几十 MB 的 `1.in` 不会被塞进插件内存。
  ],
)
