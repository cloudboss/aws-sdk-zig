/// Status of a DataView
pub const DataViewStatus = enum {
    running,
    starting,
    failed,
    cancelled,
    timeout,
    success,
    pending,
    failed_cleanup_failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .starting = "STARTING",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .timeout = "TIMEOUT",
        .success = "SUCCESS",
        .pending = "PENDING",
        .failed_cleanup_failed = "FAILED_CLEANUP_FAILED",
    };
};
