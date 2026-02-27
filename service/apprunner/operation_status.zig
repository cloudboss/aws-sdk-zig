pub const OperationStatus = enum {
    pending,
    in_progress,
    failed,
    succeeded,
    rollback_in_progress,
    rollback_failed,
    rollback_succeeded,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_failed = "ROLLBACK_FAILED",
        .rollback_succeeded = "ROLLBACK_SUCCEEDED",
    };
};
