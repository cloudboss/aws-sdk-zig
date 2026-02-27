pub const AccountAttributeName = enum {
    account_tier,
    default_protect_configuration_id,

    pub const json_field_names = .{
        .account_tier = "ACCOUNT_TIER",
        .default_protect_configuration_id = "DEFAULT_PROTECT_CONFIGURATION_ID",
    };
};
