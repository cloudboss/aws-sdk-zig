pub const GraphSummaryType = enum {
    basic,
    detailed,

    pub const json_field_names = .{
        .basic = "BASIC",
        .detailed = "DETAILED",
    };
};
