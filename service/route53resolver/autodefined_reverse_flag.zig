pub const AutodefinedReverseFlag = enum {
    enable,
    disable,
    use_local_resource_setting,

    pub const json_field_names = .{
        .enable = "ENABLE",
        .disable = "DISABLE",
        .use_local_resource_setting = "USE_LOCAL_RESOURCE_SETTING",
    };
};
