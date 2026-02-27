pub const AnalyticsNodeType = enum {
    inner,
    exit,

    pub const json_field_names = .{
        .inner = "Inner",
        .exit = "Exit",
    };
};
