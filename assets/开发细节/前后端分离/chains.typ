// 各功能板块的抽象链：同一列对齐，就能看出哪些抽象是共用的。
// 用在：== 前后端分离，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let B = rgb("#fdf0f0")
#let O = rgb("#eef6ee")

#text(size: 12pt)[
  #diagram(
    node-stroke: 0.7pt,
    node-corner-radius: 4pt,
    node-inset: 6pt,
    edge-stroke: 0.9pt,
    spacing: (28pt, 18pt),

    node((-0.85, 0), align(right)[ren], stroke: none, fill: none, width: 64pt),
    node((-0.85, 1), align(right)[dump], stroke: none, fill: none, width: 64pt),
    node((-0.85, 2), align(right)[dmk gen], stroke: none, fill: none, width: 64pt),
    node((-0.85, 3), align(right)[validate], stroke: none, fill: none, width: 64pt),
    node((-0.85, 4), align(right)[test], stroke: none, fill: none, width: 64pt),
    node((-0.85, 5), align(right)[doc], stroke: none, fill: none, width: 64pt),

    node((0, 0), [`Document`], fill: B, name: <d0>),
    node((1, 0), [`RenProcessor`], fill: B, name: <d1>),
    node((2, 0), [`Renderer`], fill: B, name: <d2>),
    node((3.2, 0), [题面], fill: O, name: <d3>),
    edge(<d0.east>, <d1.west>, "->", [改写]),
    edge(<d1.east>, <d2.west>, "->", [渲染]),
    edge(<d2.east>, <d3.west>, "->"),

    node((0, 1), [`DumpDocument`], fill: B, name: <m0>),
    node((1, 1), [`Dumper`], fill: B, name: <m1>),
    node((3.2, 1), [评测平台目录], fill: O, name: <m3>),
    edge(<m0.east>, <m1.west>, "->", [导出]),
    edge(<m1.east>, <m3.west>, "->"),

    node((0, 2), [`Generator`], fill: B, name: <g0>),
    node((1.4, 2), [输入与答案], fill: O, name: <g1>),
    edge(<g0.east>, <g1.west>, "->", [参数 + 种子]),

    node((0, 3), [`Validator`], fill: B, name: <v0>),
    node((1.4, 3), [通过 / 失败], fill: O, name: <v1>),
    edge(<v0.east>, <v1.west>, "->", [校验]),

    node((0, 4), [`Data`], fill: B, name: <t0>),
    node((1, 4), [`Runner`], fill: B, name: <t1>),
    node((3.2, 4), [结果 → 分数], fill: O, name: <t3>),
    edge(<t0.east>, <t1.west>, "->", [执行]),
    edge(<t1.east>, <t3.west>, "->", [前端算分]),

    node((0, 5), [`Document`], fill: B, name: <x0>),
    node((2, 5), [报告], fill: O, name: <x2>),
    edge(<x0.east>, <x2.west>, "->", [按规则检查]),
  )
]
