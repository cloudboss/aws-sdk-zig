/// A predefined code indicating the error that caused the failure.
pub const FailureCode = enum {
    /// The request failed to satisfy the constraints specified by the service
    invalid_input,
    /// Request throttled due to large number of pending dial requests
    request_throttled,
    /// Unexpected error during processing of request
    unknown_error,

    pub const json_field_names = .{
        .invalid_input = "INVALID_INPUT",
        .request_throttled = "REQUEST_THROTTLED",
        .unknown_error = "UNKNOWN_ERROR",
    };
};
