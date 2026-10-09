// 前后端分层：依赖只准自上而下。
// 用在：== 前后端分离，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#text(size: 11.5pt)[
  #diagram(
    node-stroke: 0.7pt,
    node-corner-radius: 4pt,
    node-inset: 6pt,
    edge-stroke: 0.9pt,
    spacing: (46pt, 22pt),
    node((0, 0), [*前端*　`tuack-ng`], name: <front>, fill: rgb("#eaf2fb")),
    node((0, 1), [*后端*　`tuack-lib`], name: <back>,
         stroke: 1.4pt + rgb("#e8a4a4"), fill: rgb("#fef7f7")),
    edge(<front.south>, <back.north>, "->", [只准向下]),
    node((-1.5, 2), [`tuack-utils`], name: <u>, fill: rgb("#eef6ee")),
    node((-0.5, 2), [`tuack-config`], name: <c>, fill: rgb("#eef6ee")),
    node((0.5, 2), [`tuack-plugin-sdk`], name: <p>, fill: rgb("#eef6ee")),
    node((1.5, 2), [`tuack-ng-parser`], name: <r>, fill: rgb("#eef6ee")),
    edge(<back.south>, <u.north>, "->"),
    edge(<back.south>, <c.north>, "->"),
    edge(<back.south>, <p.north>, "->"),
    edge(<back.south>, <r.north>, "->"),
  )
]
