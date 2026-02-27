pub const EphemerisStatus = enum {
    validating,
    invalid,
    @"error",
    enabled,
    disabled,
    expired,

    pub const json_field_names = .{
        .validating = "VALIDATING",
        .invalid = "INVALID",
        .@"error" = "ERROR",
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .expired = "EXPIRED",
    };
};
