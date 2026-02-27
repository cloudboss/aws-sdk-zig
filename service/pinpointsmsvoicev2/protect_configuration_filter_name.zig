pub const ProtectConfigurationFilterName = enum {
    account_default,
    deletion_protection_enabled,

    pub const json_field_names = .{
        .account_default = "ACCOUNT_DEFAULT",
        .deletion_protection_enabled = "DELETION_PROTECTION_ENABLED",
    };
};
