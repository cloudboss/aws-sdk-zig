pub const PolicyTypeStatus = enum {
    enabled,
    pending_enable,
    pending_disable,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .pending_enable = "PENDING_ENABLE",
        .pending_disable = "PENDING_DISABLE",
    };
};
