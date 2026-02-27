pub const ConfigChangeStatus = enum {
    pending,
    initializing,
    validating,
    validation_failed,
    applying_changes,
    completed,
    pending_user_input,
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .initializing = "INITIALIZING",
        .validating = "VALIDATING",
        .validation_failed = "VALIDATION_FAILED",
        .applying_changes = "APPLYING_CHANGES",
        .completed = "COMPLETED",
        .pending_user_input = "PENDING_USER_INPUT",
        .cancelled = "CANCELLED",
    };
};
