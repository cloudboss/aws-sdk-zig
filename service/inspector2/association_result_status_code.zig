pub const AssociationResultStatusCode = enum {
    internal_error,
    access_denied,
    scan_configuration_not_found,
    invalid_input,
    resource_not_found,
    quota_exceeded,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .access_denied = "ACCESS_DENIED",
        .scan_configuration_not_found = "SCAN_CONFIGURATION_NOT_FOUND",
        .invalid_input = "INVALID_INPUT",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .quota_exceeded = "QUOTA_EXCEEDED",
    };
};
