pub const Status = enum {
    disabled,
    enabled,
    force_enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .force_enabled = "FORCE_ENABLED",
    };
};
