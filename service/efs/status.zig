pub const Status = enum {
    enabled,
    enabling,
    disabled,
    disabling,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .enabling = "ENABLING",
        .disabled = "DISABLED",
        .disabling = "DISABLING",
    };
};
