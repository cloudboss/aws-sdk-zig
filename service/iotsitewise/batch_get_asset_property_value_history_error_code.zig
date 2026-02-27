pub const BatchGetAssetPropertyValueHistoryErrorCode = enum {
    resource_not_found_exception,
    invalid_request_exception,
    access_denied_exception,

    pub const json_field_names = .{
        .resource_not_found_exception = "ResourceNotFoundException",
        .invalid_request_exception = "InvalidRequestException",
        .access_denied_exception = "AccessDeniedException",
    };
};
