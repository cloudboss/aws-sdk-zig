pub const AccessStatus = enum {
    enabled,
    under_change,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .under_change = "UNDER_CHANGE",
        .disabled = "DISABLED",
    };
};
