pub const FleetContextCode = enum {
    create_failed,
    update_failed,
    action_required,
    pending_deletion,
    insufficient_capacity,

    pub const json_field_names = .{
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .action_required = "ACTION_REQUIRED",
        .pending_deletion = "PENDING_DELETION",
        .insufficient_capacity = "INSUFFICIENT_CAPACITY",
    };
};
