pub const ResolverAutodefinedReverseStatus = enum {
    enabling,
    enabled,
    disabling,
    disabled,
    updating_to_use_local_resource_setting,
    use_local_resource_setting,

    pub const json_field_names = .{
        .enabling = "Enabling",
        .enabled = "Enabled",
        .disabling = "Disabling",
        .disabled = "Disabled",
        .updating_to_use_local_resource_setting = "UpdatingToUseLocalResourceSetting",
        .use_local_resource_setting = "UseLocalResourceSetting",
    };
};
