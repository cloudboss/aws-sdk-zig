pub const ConfiguredTableAnalysisRuleType = enum {
    aggregation,
    list,
    custom,

    pub const json_field_names = .{
        .aggregation = "AGGREGATION",
        .list = "LIST",
        .custom = "CUSTOM",
    };
};
