pub const Status = enum {
    enabling,
    enabled,
    disabling,
    disabled,
    suspending,
    suspended,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .suspending = "SUSPENDING",
        .suspended = "SUSPENDED",
    };
};
