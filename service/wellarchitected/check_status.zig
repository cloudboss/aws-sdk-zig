pub const CheckStatus = enum {
    okay,
    warning,
    @"error",
    not_available,
    fetch_failed,

    pub const json_field_names = .{
        .okay = "OKAY",
        .warning = "WARNING",
        .@"error" = "ERROR",
        .not_available = "NOT_AVAILABLE",
        .fetch_failed = "FETCH_FAILED",
    };
};
