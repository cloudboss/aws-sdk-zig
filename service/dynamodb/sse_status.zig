pub const SSEStatus = enum {
    enabling,
    enabled,
    disabling,
    disabled,
    updating,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .updating = "UPDATING",
    };
};
