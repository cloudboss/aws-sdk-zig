pub const BackupJobState = enum {
    created,
    pending,
    running,
    aborting,
    aborted,
    completed,
    failed,
    expired,
    partial,

    pub const json_field_names = .{
        .created = "CREATED",
        .pending = "PENDING",
        .running = "RUNNING",
        .aborting = "ABORTING",
        .aborted = "ABORTED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .expired = "EXPIRED",
        .partial = "PARTIAL",
    };
};
