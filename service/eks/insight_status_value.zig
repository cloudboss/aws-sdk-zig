pub const InsightStatusValue = enum {
    passing,
    warning,
    @"error",
    unknown,

    pub const json_field_names = .{
        .passing = "PASSING",
        .warning = "WARNING",
        .@"error" = "ERROR",
        .unknown = "UNKNOWN",
    };
};
