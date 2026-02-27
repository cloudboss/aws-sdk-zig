pub const MetricsLevel = enum {
    application,
    task,
    operator,
    parallelism,

    pub const json_field_names = .{
        .application = "APPLICATION",
        .task = "TASK",
        .operator = "OPERATOR",
        .parallelism = "PARALLELISM",
    };
};
