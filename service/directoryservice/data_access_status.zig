pub const DataAccessStatus = enum {
    disabled,
    disabling,
    enabled,
    enabling,
    failed,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .disabling = "DISABLING",
        .enabled = "ENABLED",
        .enabling = "ENABLING",
        .failed = "FAILED",
    };
};
