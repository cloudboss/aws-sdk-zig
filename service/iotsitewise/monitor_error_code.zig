pub const MonitorErrorCode = enum {
    internal_failure,
    validation_error,
    limit_exceeded,

    pub const json_field_names = .{
        .internal_failure = "INTERNAL_FAILURE",
        .validation_error = "VALIDATION_ERROR",
        .limit_exceeded = "LIMIT_EXCEEDED",
    };
};
