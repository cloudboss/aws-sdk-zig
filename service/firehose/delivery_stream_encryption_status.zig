pub const DeliveryStreamEncryptionStatus = enum {
    enabled,
    enabling,
    enabling_failed,
    disabled,
    disabling,
    disabling_failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .enabling = "ENABLING",
        .enabling_failed = "ENABLING_FAILED",
        .disabled = "DISABLED",
        .disabling = "DISABLING",
        .disabling_failed = "DISABLING_FAILED",
    };
};
