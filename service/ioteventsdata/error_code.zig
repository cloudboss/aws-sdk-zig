pub const ErrorCode = enum {
    resource_not_found_exception,
    invalid_request_exception,
    internal_failure_exception,
    service_unavailable_exception,
    throttling_exception,

    pub const json_field_names = .{
        .resource_not_found_exception = "ResourceNotFoundException",
        .invalid_request_exception = "InvalidRequestException",
        .internal_failure_exception = "InternalFailureException",
        .service_unavailable_exception = "ServiceUnavailableException",
        .throttling_exception = "ThrottlingException",
    };
};
