pub const SoftwareUpdateStatus = enum {
    pending,
    in_progress,
    succeeded,
    failed,
    rollback_in_progress,
    rollback_complete,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_complete = "ROLLBACK_COMPLETE",
    };
};
