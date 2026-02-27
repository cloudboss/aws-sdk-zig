/// A predefined code indicating the error that caused the failure.
pub const FailureCode = enum {
    /// The request failed to satisfy the constraints specified by the service
    invalid_input,
    /// The request was throttled due to excessive usage
    request_throttled,
    /// Unexpected error during processing of request
    unknown_error,
    /// Request throttled due to large number of pending dial requests
    buffer_limit_exceeded,

    pub const json_field_names = .{
        .invalid_input = "INVALID_INPUT",
        .request_throttled = "REQUEST_THROTTLED",
        .unknown_error = "UNKNOWN_ERROR",
        .buffer_limit_exceeded = "BUFFER_LIMIT_EXCEEDED",
    };
};
