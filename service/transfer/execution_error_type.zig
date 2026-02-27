pub const ExecutionErrorType = enum {
    permission_denied,
    custom_step_failed,
    throttled,
    already_exists,
    not_found,
    bad_request,
    timeout,
    internal_server_error,

    pub const json_field_names = .{
        .permission_denied = "PERMISSION_DENIED",
        .custom_step_failed = "CUSTOM_STEP_FAILED",
        .throttled = "THROTTLED",
        .already_exists = "ALREADY_EXISTS",
        .not_found = "NOT_FOUND",
        .bad_request = "BAD_REQUEST",
        .timeout = "TIMEOUT",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };
};
