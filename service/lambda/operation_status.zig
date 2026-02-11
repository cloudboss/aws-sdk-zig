pub const OperationStatus = enum {
    started,
    pending,
    ready,
    succeeded,
    failed,
    cancelled,
    timed_out,
    stopped,

    pub const json_field_names = .{
        .started = "STARTED",
        .pending = "PENDING",
        .ready = "READY",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .timed_out = "TIMED_OUT",
        .stopped = "STOPPED",
    };
};
