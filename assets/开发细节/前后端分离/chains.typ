// 各功能板块的抽象链。三色区分：结构体（数据）、trait（能力）、产物。
// 每一跳固定跨一列、每列方框定宽，所以同列左端对齐、箭头等长。
// 用在：== 前后端分离，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let S = rgb("#eaf2fb")  // 结构体
#let T = rgb("#fdf0f0")  // trait
#let O = rgb("#eef6ee")  // 产物

#let L = 62pt   // 板块名那一栏
#let C0 = 100pt
#let C1 = 140pt
#let C2 = 100pt
#let C3 = 34pt
#let cell(w, body) = box(width: w, align(center, body))  // 框定宽保证列对齐，框内文字居中

#figure(caption: [Tuack-NG 各个功能使用的后端抽象一览], numbering: none)[
  #text(size: 14pt)[
    #diagram(
      node-stroke: 0.7pt,
      node-corner-radius: 4pt,
      node-inset: 4pt,
      edge-stroke: 1pt,
      spacing: (46pt, 14pt),

      node((-1, 0), cell(L)[渲染], stroke: none, fill: none),
      node((-1, 1), cell(L)[导出], stroke: none, fill: none),
      node((-1, 2), cell(L)[数据生成], stroke: none, fill: none),
      node((-1, 3), cell(L)[校验], stroke: none, fill: none),
      node((-1, 4), cell(L)[测试], stroke: none, fill: none),
      node((-1, 5), cell(L)[题面检查], stroke: none, fill: none),

      node((0, 0), cell(C0)[`Document`], fill: S, name: <r0>),
      node((1, 0), cell(C1)[`RenProcessor`], fill: T, name: <r1>),
      node((2, 0), cell(C2)[`Renderer`], fill: T, name: <r2>),
      node((3, 0), cell(C3)[题面], fill: O, name: <r3>),
      edge(<r0.east>, <r1.west>, "->", [改写]),
      edge(<r1.east>, <r2.west>, "->", [渲染]),
      edge(<r2.east>, <r3.west>, "->"),

      node((0, 1), cell(C0)[`DumpDocument`], fill: S, name: <u0>),
      node((1, 1), cell(C1)[`Dumper`], fill: T, name: <u1>),
      node((2, 1), cell(C2)[评测平台目录], fill: O, name: <u2>),
      edge(<u0.east>, <u1.west>, "->", [导出]),
      edge(<u1.east>, <u2.west>, "->"),

      node((0, 2), cell(C0)[`DmkSession`], fill: S, name: <g0>),
      node((1, 2), cell(C1)[`Generator` & `Runner`], fill: T, name: <g1>),
      node((2, 2), cell(C2)[输入与答案], fill: O, name: <g2>),
      edge(<g0.east>, <g1.west>, "->", [造输入 / 出答案]),
      edge(<g1.east>, <g2.west>, "->", [写盘]),

      node((0, 3), cell(C0)[`Validator`], fill: T, name: <v0>),
      node((1, 3), cell(C1)[通过 / 失败], fill: O, name: <v1>),
      edge(<v0.east>, <v1.west>, "->", [校验]),

      node((0, 4), cell(C0)[`TestSession`], fill: S, name: <t0>),
      node((1, 4), cell(C1)[`Runner` & `Checker`], fill: T, name: <t1>),
      node((2, 4), cell(C2)[分数], fill: O, name: <t2>),
      edge(<t0.east>, <t1.west>, "->", [喂入 `Data`]),
      edge(<t1.east>, <t2.west>, "->", [算分]),

      node((0, 5), cell(C0)[`Document`], fill: S, name: <c0>),
      node((1, 5), cell(C1)[报告], fill: O, name: <c1>),
      edge(<c0.east>, <c1.west>, "->", [按规则检查]),

      node((-1, 6.4), cell(L)[图例], stroke: none, fill: none),
      node(
        (0.54, 6.4),
        box(align(center)[
          #box(fill: S, width: 18pt, height: 12pt) #h(5pt) 结构体（数据）
          #h(26pt)
          #box(fill: T, width: 18pt, height: 12pt) #h(5pt) trait（能力）
          #h(26pt)
          #box(fill: O, width: 18pt, height: 12pt) #h(5pt) 产物
        ]),
        stroke: none,
        fill: none,
      ),
    )
  ]
]
