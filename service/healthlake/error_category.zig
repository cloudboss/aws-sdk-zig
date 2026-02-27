pub const ErrorCategory = enum {
    retryable_error,
    non_retryable_error,

    pub const json_field_names = .{
        .retryable_error = "RETRYABLE_ERROR",
        .non_retryable_error = "NON_RETRYABLE_ERROR",
    };
};
