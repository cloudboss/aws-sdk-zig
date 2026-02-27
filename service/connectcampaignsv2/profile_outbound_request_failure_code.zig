/// Predefined code indicating the error that caused the failure
pub const ProfileOutboundRequestFailureCode = enum {
    /// Unexpected error during processing of request
    unknown_error,
    /// The specified resource was not found
    resource_not_found,
    /// The specified resource conflicts with another resource
    conflict,
    /// Request throttled due to large number of requests
    request_throttled,
    /// The request failed to satisfy the constraints specified by the service
    invalid_input,

    pub const json_field_names = .{
        .unknown_error = "UNKNOWN_ERROR",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .conflict = "CONFLICT",
        .request_throttled = "REQUEST_THROTTLED",
        .invalid_input = "INVALID_INPUT",
    };
};
