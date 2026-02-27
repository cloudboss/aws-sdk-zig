pub const TaskRunStatus = enum {
    pending,
    ready,
    assigned,
    starting,
    scheduled,
    interrupting,
    running,
    suspended,
    canceled,
    failed,
    succeeded,
    not_compatible,

    pub const json_field_names = .{
        .pending = "PENDING",
        .ready = "READY",
        .assigned = "ASSIGNED",
        .starting = "STARTING",
        .scheduled = "SCHEDULED",
        .interrupting = "INTERRUPTING",
        .running = "RUNNING",
        .suspended = "SUSPENDED",
        .canceled = "CANCELED",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .not_compatible = "NOT_COMPATIBLE",
    };
};
