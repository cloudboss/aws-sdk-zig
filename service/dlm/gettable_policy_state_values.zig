pub const GettablePolicyStateValues = enum {
    enabled,
    disabled,
    @"error",

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .@"error" = "ERROR",
    };
};
