pub const AccessStatus = enum {
    enabled,
    disabled,
    pending,
    failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .pending = "PENDING",
        .failed = "FAILED",
    };
};
