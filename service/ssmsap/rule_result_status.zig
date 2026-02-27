pub const RuleResultStatus = enum {
    passed,
    failed,
    warning,
    info,
    unknown,

    pub const json_field_names = .{
        .passed = "PASSED",
        .failed = "FAILED",
        .warning = "WARNING",
        .info = "INFO",
        .unknown = "UNKNOWN",
    };
};
