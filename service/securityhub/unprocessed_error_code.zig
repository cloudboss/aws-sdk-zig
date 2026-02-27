pub const UnprocessedErrorCode = enum {
    invalid_input,
    access_denied,
    not_found,
    resource_not_found,
    limit_exceeded,

    pub const json_field_names = .{
        .invalid_input = "INVALID_INPUT",
        .access_denied = "ACCESS_DENIED",
        .not_found = "NOT_FOUND",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .limit_exceeded = "LIMIT_EXCEEDED",
    };
};
