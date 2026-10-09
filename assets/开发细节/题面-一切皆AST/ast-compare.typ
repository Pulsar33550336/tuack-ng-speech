// 题面 AST 对照页的数据：左原文、右解析树，同一种语法元素同一种颜色。
// 用在：== 题面 - 一切皆 AST。
#import "../../style.typ": *

// 左栏：题面 Markdown 原文，逐元素上色
#let m-md = src-text("
<m1>$1 \\leq n \\leq 10^5$</m1><m10>，</m10><m1>$r_i \\leq 2$</m1>

<m2>$$</m2>
<m2>\\sum_{i=1}^{n} r_i \\leq 10^{18}</m2>
<m2>$$</m2>

<m3>![</m3><m4>示例图片</m4><m3>](</m3><m5>img/demo.png</m5><m3>)</m3><m11>{</m11><m6>width=40%</m6><m11>}</m11>

<m7>:::</m7><m14>figure</m14><m13>{</m13><m8>caption=\"看我！\"</m8><m13>}</m13>
<m10>这是</m10><m12>*居中*</m12><m10>文字！</m10>
<m7>:::</m7>")


// 右栏：解析出来的树，按节点类型上色；缩进就是行首空格（Span 已删，才放得下）
#let m-ast = mtext("
Document { blocks: [
    Paragraph([
        <m1>Latex(\"1 \\\\leq n \\\\leq 10^5\"),</m1>
        <m10>Text(\"，\"),</m10>
        <m1>Latex(\"r_i \\\\leq 2\")</m1>
    ]),
    <m2>LatexBlock(\"\\\\sum_{i=1}^{n} r_i \\\\leq 10^{18}\\n\"),</m2>
    Paragraph([
        <m3>Image(Image {</m3>
        <m3>    </m3><m5>destination: \"img/demo.png\",</m5>
        <m3>    </m3><m3>title: None,</m3>
        <m3>    </m3><m4>alt: \"示例图片\",</m4>
        <m3>    </m3><m11>attr: Some(ImageAttributes {</m11>
        <m3>    </m3><m11>    </m11><m6>width: Some(\"40%\"),</m6>
        <m3>    </m3><m11>    </m11><m11>height: None,</m11>
        <m3>    </m3><m11>}),</m11>
        <m3>}),</m3>
    ]),
    <m7>Container(Container {</m7>
    <m7>    </m7><m7>kind: </m7><m14>\"figure\",</m14>
    <m7>    </m7><m13>params: [</m13><m8>KeyValue(\"caption\", \"看我！\")</m8><m13>],</m13>
    <m7>    </m7><m7>blocks: [</m7>
    <m7>        </m7>Paragraph([
    <m7>        </m7>    <m10>Text(\"这是\")</m10>, <m12>Emphasis([Text(\"居中\")])</m12>, <m10>Text(\"文字！\"),</m10>
    <m7>        </m7>]),
    <m7>    </m7><m7>],</m7>
    <m7>}),</m7>
] }")
