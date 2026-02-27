pub const FederationStatus = enum {
    enabling,
    enabled,
    disabling,
    disabled,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
    };
};
