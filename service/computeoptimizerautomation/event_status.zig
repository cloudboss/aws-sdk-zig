pub const EventStatus = enum {
    ready,
    in_progress,
    complete,
    failed,
    cancelled,
    rollback_ready,
    rollback_in_progress,
    rollback_complete,
    rollback_failed,

    pub const json_field_names = .{
        .ready = "READY",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .rollback_ready = "ROLLBACK_READY",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_complete = "ROLLBACK_COMPLETE",
        .rollback_failed = "ROLLBACK_FAILED",
    };
};
