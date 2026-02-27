pub const ConnectorOperationState = enum {
    pending,
    update_in_progress,
    update_complete,
    update_failed,
    rollback_in_progress,
    rollback_failed,
    rollback_complete,

    pub const json_field_names = .{
        .pending = "PENDING",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_failed = "ROLLBACK_FAILED",
        .rollback_complete = "ROLLBACK_COMPLETE",
    };
};
