pub const ErrorCode = enum {
    bad_request,
    forbidden,
    not_found,
    resource_limit_exceeded,
    service_failure,
    service_unavailable,
    throttling,

    pub const json_field_names = .{
        .bad_request = "BadRequest",
        .forbidden = "Forbidden",
        .not_found = "NotFound",
        .resource_limit_exceeded = "ResourceLimitExceeded",
        .service_failure = "ServiceFailure",
        .service_unavailable = "ServiceUnavailable",
        .throttling = "Throttling",
    };
};
