pub const ErrorCode = enum {
    validation_error,
    internal_failure,

    pub const json_field_names = .{
        .validation_error = "VALIDATION_ERROR",
        .internal_failure = "INTERNAL_FAILURE",
    };
};
