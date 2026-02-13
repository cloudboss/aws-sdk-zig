pub const MaintenanceWindowExecutionStatus = enum {
    pending,
    in_progress,
    success,
    failed,
    timed_out,
    cancelling,
    cancelled,
    skipped_overlapping,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_progress = "InProgress",
        .success = "Success",
        .failed = "Failed",
        .timed_out = "TimedOut",
        .cancelling = "Cancelling",
        .cancelled = "Cancelled",
        .skipped_overlapping = "SkippedOverlapping",
    };
};
