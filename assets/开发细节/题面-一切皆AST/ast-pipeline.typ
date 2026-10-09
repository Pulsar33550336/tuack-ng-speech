// 流水线图：题面源 → parse → AST → 处理器 → AST′ → 打印器。
// 用在：== 题面 - 一切皆 AST。
#import "@preview/fletcher:0.5.8": diagram, edge, node

// 处理器那组用 enclose 做成大块包小块；节点按 y = (i - (n-1)/2) * step 对称排布，
// step 必须取整数，否则 Fletcher 按行的网格行距会非线性插值、间距不匀。
#figure(caption: [Tuack-NG 的 AST 流程图], numbering: none)[
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
]
