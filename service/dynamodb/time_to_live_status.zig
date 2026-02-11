pub const TimeToLiveStatus = enum {
    enabling,
    disabling,
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .disabling = "DISABLING",
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
