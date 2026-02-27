pub const CentralizationFailureReason = enum {
    trusted_access_not_enabled,
    destination_account_not_in_organization,
    internal_server_error,

    pub const json_field_names = .{
        .trusted_access_not_enabled = "TRUSTED_ACCESS_NOT_ENABLED",
        .destination_account_not_in_organization = "DESTINATION_ACCOUNT_NOT_IN_ORGANIZATION",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };
};
