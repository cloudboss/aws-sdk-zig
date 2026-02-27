pub const BackupJobStatus = enum {
    created,
    pending,
    running,
    aborting,
    aborted,
    completed,
    failed,
    expired,
    partial,
    aggregate_all,
    any,

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
        .aggregate_all = "AGGREGATE_ALL",
        .any = "ANY",
    };
};
