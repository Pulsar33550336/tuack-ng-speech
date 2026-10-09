// Markdown 导出那一页的数据：同一段题面在三套目标下的写法差异。
// 用在：== 题面 - 渲染。
#import "style.typ": *

// 这两栏用的字号与行高（比正文小）
#let MD-CODE = 8.5pt
#let MD-LH = 12pt
// 行内高亮与等宽文本的包装

// 三份导出共有的开头：两个标题各带一行正文（H 为标题层级）
#let md-text(s) = mtext(s, size: MD-CODE, lh: MD-LH)

#let md-head(H) = md-text(
  "
<m1>" + H + " 输入格式</m1>

第一行一个整数 $n$。

<m1>" + H + " 输出格式</m1>

一行一个整数。
"
)

// 纯 Markdown：表格照写，合并单元格用 ^ 表示
#let md-plain = (..md-head("##"), ..md-text("
<m2>| 测试点 | $n \\le$ |</m2>
<m2>| :----: | ------: |</m2>
<m2>|  $1$   |    $10$ |</m2>
<m2>|  $2$   |       ^ |</m2>"))

// LOJ：合并单元格要展开到每个格位，并用 <!--row:R,col:C--> 标出原位置
#let md-loj = (..md-head("##"), ..md-text("
<m2>| 测试点<<!--row:0,col: 0--> | $n \\le$<<!--row:0,col: 1--> |</m2>
<m2>| :-----------------------: | -------------------------: |</m2>
<m2>|  $1$<<!--row:1,col: 0-->   |    $10$<<!--row:1,col: 1--> |</m2>
<m2>|  $2$<<!--row:2,col: 0-->   |    $10$<<!--row:1,col: 1--> |</m2>"))

// UOJ：表格写成 HTML，用 rowspan 表达合并；标题层级加一（## → ###）
#let md-uoj = (..md-head("###"), ..md-text("
<m2><<table></m2>
<m2>  <<thead></m2>
<m2>    <<tr></m2>
<m2>      <<th align=\"center\"> 测试点 <</th></m2>
<m2>      <<th align=\"right\"> $n \\le$ <</th></m2>
<m2>    <</tr></m2>
<m2>  <</thead></m2>
<m2>  <<tbody></m2>
<m2>    <<tr></m2>
<m2>      <<td align=\"center\"> $1$ <</td></m2>
<m2>      <<td rowspan=\"2\" align=\"right\"> $10$ <</td></m2>
<m2>    <</tr></m2>
<m2>    <<tr></m2>
<m2>      <<td align=\"center\"> $2$ <</td></m2>
<m2>    <</tr></m2>
<m2>  <</tbody></m2>
<m2><</table></m2>"))
