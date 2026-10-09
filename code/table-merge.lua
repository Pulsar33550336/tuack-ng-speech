local il = tng.tools.inline_latex

return tng.table {
    headers = { "测试点编号", il("T ="), il("N \\le"), il("\\lvert a_i \\rvert \\le") },
    align = { "center", "center", "center", "center" },

    data = tng.config.data_cases:map(function(group)
        local args = group.args
        return {
            tng.tools.cases(group.id),
            tng.tools.inline_latex(args.T),
            tng.tools.inline_latex(args.max_n),
            tng.tools.inline_latex(args.max_a)
        }
    end),

    merge_rules = {
        { col = 2, merge_row = true },
        { col = 3, merge_row = true },
        { col = 4, merge_row = true },
    },
}
