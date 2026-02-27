pub const RegionOptStatus = enum {
    enabled,
    enabling,
    disabling,
    disabled,
    enabled_by_default,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .enabling = "ENABLING",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .enabled_by_default = "ENABLED_BY_DEFAULT",
    };
};
