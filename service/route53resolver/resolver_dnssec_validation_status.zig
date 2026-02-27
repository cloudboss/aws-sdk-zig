pub const ResolverDNSSECValidationStatus = enum {
    enabling,
    enabled,
    disabling,
    disabled,
    update_to_use_local_resource_setting,
    use_local_resource_setting,

    pub const json_field_names = .{
        .enabling = "Enabling",
        .enabled = "Enabled",
        .disabling = "Disabling",
        .disabled = "Disabled",
        .update_to_use_local_resource_setting = "UpdateToUseLocalResourceSetting",
        .use_local_resource_setting = "UseLocalResourceSetting",
    };
};
