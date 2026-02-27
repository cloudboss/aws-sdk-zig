pub const PlanCacheType = enum {
    enabled,
    disabled,
    auto,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .auto = "AUTO",
    };
};
