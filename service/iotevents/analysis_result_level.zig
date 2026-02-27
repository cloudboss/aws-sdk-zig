pub const AnalysisResultLevel = enum {
    info,
    warning,
    @"error",

    pub const json_field_names = .{
        .info = "INFO",
        .warning = "WARNING",
        .@"error" = "ERROR",
    };
};
