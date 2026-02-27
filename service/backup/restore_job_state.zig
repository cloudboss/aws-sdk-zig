pub const RestoreJobState = enum {
    created,
    pending,
    running,
    aborted,
    completed,
    failed,
    aggregate_all,
    any,

    pub const json_field_names = .{
        .created = "CREATED",
        .pending = "PENDING",
        .running = "RUNNING",
        .aborted = "ABORTED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .aggregate_all = "AGGREGATE_ALL",
        .any = "ANY",
    };
};
