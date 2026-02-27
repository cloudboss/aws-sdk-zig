pub const ErrorCode = enum {
    internal_error,
    invalid_request,
    resource_inactive,
    resource_not_found,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_request = "INVALID_REQUEST",
        .resource_inactive = "RESOURCE_INACTIVE",
        .resource_not_found = "RESOURCE_NOT_FOUND",
    };
};
