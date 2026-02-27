pub const QAResultType = enum {
    dashboard_visual,
    generated_answer,
    no_answer,

    pub const json_field_names = .{
        .dashboard_visual = "DASHBOARD_VISUAL",
        .generated_answer = "GENERATED_ANSWER",
        .no_answer = "NO_ANSWER",
    };
};
