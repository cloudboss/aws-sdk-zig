pub const DataQualityRuleResultStatus = enum {
    pass,
    fail,
    @"error",

    pub const json_field_names = .{
        .pass = "PASS",
        .fail = "FAIL",
        .@"error" = "ERROR",
    };
};
