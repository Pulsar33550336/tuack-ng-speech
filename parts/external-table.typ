// 外置表格那一页的数据。用在：== 题面 - 语法 - 外置表格。
#import "style.typ": *

// Jinja 的 for 循环直接生成带合并单元格的 Markdown 表格，也就是「题面里变成一坨」的
// 写法；调用处 #cblock(tbl-jinja, hl: 6) 指定高亮行。
#let tbl-jinja = str-lines("
| 测试点编号 | $T =$ | $N \\le$ | $\\lvert a_i \\rvert \\le$ |
| :-: | :-: | :-: | :-: |
{%- set prev_T = None %}
{%- set prev_max_n = None %}
{%- set prev_max_a = None %}
{%- for group in data_cases %}
| {{ tools.cases(group.id) }} | {% if group.args.T == prev_T %} ^ {% else %}${{ group.args.T }}${%- set prev_T = group.args.T %}{% endif %} | {% if group.args.max_n == prev_max_n %} ^ {% else %}${{ group.args.max_n }}${%- set prev_max_n = group.args.max_n %}{% endif %} | {% if group.args.max_a == prev_max_a %} ^ {% else %}${{ group.args.max_a }}${%- set prev_max_a = group.args.max_a %}{% endif %} |
{%- endfor %}
")

// 拿出来写：tables/1.lua（导数之殇的真实文件）
