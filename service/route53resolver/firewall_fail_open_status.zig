pub const FirewallFailOpenStatus = enum {
    enabled,
    disabled,
    use_local_resource_setting,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .use_local_resource_setting = "USE_LOCAL_RESOURCE_SETTING",
    };
};
