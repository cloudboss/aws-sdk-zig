pub const LoggingStrategy = enum {
    vended_logs,
    legacy_cloudwatch,

    pub const json_field_names = .{
        .vended_logs = "VENDED_LOGS",
        .legacy_cloudwatch = "LEGACY_CLOUDWATCH",
    };
};
