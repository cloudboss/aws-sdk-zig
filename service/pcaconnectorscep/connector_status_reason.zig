pub const ConnectorStatusReason = enum {
    internal_failure,
    privateca_access_denied,
    privateca_invalid_state,
    privateca_resource_not_found,

    pub const json_field_names = .{
        .internal_failure = "INTERNAL_FAILURE",
        .privateca_access_denied = "PRIVATECA_ACCESS_DENIED",
        .privateca_invalid_state = "PRIVATECA_INVALID_STATE",
        .privateca_resource_not_found = "PRIVATECA_RESOURCE_NOT_FOUND",
    };
};
