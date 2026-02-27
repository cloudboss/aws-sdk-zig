pub const InstanceStatus = enum {
    pending,
    in_progress,
    succeeded,
    failed,
    skipped,
    unknown,
    ready,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .skipped = "SKIPPED",
        .unknown = "UNKNOWN",
        .ready = "READY",
    };
};
