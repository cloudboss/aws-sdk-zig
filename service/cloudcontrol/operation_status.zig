pub const OperationStatus = enum {
    pending,
    in_progress,
    success,
    failed,
    cancel_in_progress,
    cancel_complete,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .cancel_complete = "CANCEL_COMPLETE",
    };
};
