// 契约关系图：宿主在上、契约居中、实现与插件路径在下，共享数据模型垫底。
// 箭头只表达与契约层的关系，不画完整的 Cargo 依赖图。
// 用在：== 前后端分离 - 谁来实现，由 main.typ 里 #include 引入。
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let B = rgb("#eaf2fb")  // 宿主 / 实现路径
#let T = rgb("#fdf0f0")  // 契约
#let D = rgb("#eef6ee")  // 共享数据模型

#let cell(w, title, desc) = box(
  width: w,
  inset: (x: 8pt, y: 4pt),
  align(center, [
    #text(size: 13pt, weight: "bold")[#title]
    #v(3pt)
    #text(size: 10.5pt)[#desc]
  ]),
)

#figure(
  caption: [Tuack-NG 的组件关系图],
  numbering: none,
)[
  #text(size: 12pt)[
    #diagram(
      node-stroke: 0.7pt,
      node-corner-radius: 4pt,
      node-inset: 3pt,
      edge-stroke: 1pt,
      spacing: (34pt, 16pt),

      // 宿主与它的配置
      node((0, 0), cell(168pt, [`tuack-ng`], [编排流程、组装 trait 对象、处理交互与文件 I/O]), fill: B, name: <app>),
      node((1.9, 0), cell(150pt, [`tuack-config`], [配置结构：`conf.json` 的读写与迁移]), fill: D, name: <cfg>),
      edge(<app.east>, <cfg.west>, "->", [读取配置]),

      // 内置实现挂在宿主下面
      node((0.95, 1.1), cell(160pt, [`tuack-utils`], [内置实现：生成、校验、运行、渲染、导出]), fill: B, name: <utils>),
      edge(<app.south>, <utils.west>, "->", [取用内置实现]),

      // 契约层
      node((0, 2.2), cell(178pt, [`tuack-lib`], [定义 trait 与跨边界数据，不负责具体实现]), fill: T, name: <lib>),
      edge(<app.south>, <lib.north>, "->", [使用契约]),
      edge(<utils.south>, <lib.east>, "->", [实现能力]),

      // 与契约直接相关的两个共享结构
      node((0, 3.4), cell(168pt, [`tuack-ng-parser`], [提供题面 AST 能力]), fill: D, name: <parser>),
      edge(<parser.north>, <lib.south>, "->"),
      node(
        (1.9, 3.4),
        cell(150pt, [`tuack-plugin-sdk`], [WASM 插件侧接口；跨边界只走可序列化数据]),
        fill: B,
        name: <sdk>,
      ),
      edge(<sdk.west>, <lib.east>, "->", [对接契约]),
    )
  ]
]
