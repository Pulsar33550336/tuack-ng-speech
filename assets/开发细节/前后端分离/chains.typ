// 各功能板块的抽象链。三色区分：结构体（数据）、trait（能力）、产物。
// 每一跳固定跨一列，所以箭头等长；按列对齐，共用的抽象自然同列。
// 用在：== 前后端分离，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let S = rgb("#eaf2fb")  // 结构体
#let T = rgb("#fdf0f0")  // trait
#let O = rgb("#eef6ee")  // 产物

#text(size: 14pt)[
  #diagram(
    node-stroke: 0.7pt,
    node-corner-radius: 4pt,
    node-inset: 5pt,
    edge-stroke: 1pt,
    spacing: (18pt, 15pt),

    node((-0.8, 0), box(width: 74pt, align(left)[ren]), stroke: none, fill: none),
    node((-0.8, 1), box(width: 74pt, align(left)[dump]), stroke: none, fill: none),
    node((-0.8, 2), box(width: 74pt, align(left)[dmk gen]), stroke: none, fill: none),
    node((-0.8, 3), box(width: 74pt, align(left)[validate]), stroke: none, fill: none),
    node((-0.8, 4), box(width: 74pt, align(left)[test]), stroke: none, fill: none),
    node((-0.8, 5), box(width: 74pt, align(left)[doc]), stroke: none, fill: none),

    node((0, 0), [`Document`], fill: S, name: <r0>),
    node((1, 0), [`RenProcessor`], fill: T, name: <r1>),
    node((2, 0), [`Renderer`], fill: T, name: <r2>),
    node((3, 0), [题面], fill: O, name: <r3>),
    edge(<r0.east>, <r1.west>, "->", [改写]),
    edge(<r1.east>, <r2.west>, "->", [渲染]),
    edge(<r2.east>, <r3.west>, "->"),

    node((0, 1), [`DumpDocument`], fill: S, name: <u0>),
    node((1, 1), [`Dumper`], fill: T, name: <u1>),
    node((2, 1), [评测平台目录], fill: O, name: <u2>),
    edge(<u0.east>, <u1.west>, "->", [导出]),
    edge(<u1.east>, <u2.west>, "->"),

    node((0, 2), [`Generator`], fill: T, name: <g0>),
    node((1, 2), [输入与答案], fill: O, name: <g1>),
    edge(<g0.east>, <g1.west>, "->", [参数 + 种子]),

    node((0, 3), [`Validator`], fill: T, name: <v0>),
    node((1, 3), [通过 / 失败], fill: O, name: <v1>),
    edge(<v0.east>, <v1.west>, "->", [校验]),

    node((0, 4), [`Data`], fill: S, name: <t0>),
    node((1, 4), [`Runner`], fill: T, name: <t1>),
    node((2, 4), [结果 → 分数], fill: O, name: <t2>),
    edge(<t0.east>, <t1.west>, "->", [执行]),
    edge(<t1.east>, <t2.west>, "->", [前端算分]),

    node((0, 5), [`Document`], fill: S, name: <c0>),
    node((1, 5), [报告], fill: O, name: <c1>),
    edge(<c0.east>, <c1.west>, "->", [按规则检查]),

    node((-0.8, 6.5), box(width: 74pt, align(left)[图例]), stroke: none, fill: none),
    node((0.25, 6.5), box(width: 120pt, align(left)[#box(fill: S, width: 20pt, height: 13pt) #h(5pt) 结构体（数据）]), stroke: none, fill: none),
    node((1.5, 6.5), box(width: 120pt, align(left)[#box(fill: T, width: 20pt, height: 13pt) #h(5pt) trait（能力）]), stroke: none, fill: none),
    node((2.75, 6.5), box(width: 120pt, align(left)[#box(fill: O, width: 20pt, height: 13pt) #h(5pt) 产物]), stroke: none, fill: none),
    node((2.75, 6.5), align(left)[#box(fill: O, width: 20pt, height: 13pt) #h(5pt) 产物], stroke: none, fill: none),
  )
]
