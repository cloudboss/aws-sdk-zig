pub const CopyJobStatus = enum {
    created,
    running,
    aborting,
    aborted,
    completing,
    completed,
    failing,
    failed,
    partial,
    aggregate_all,
    any,

    pub const json_field_names = .{
        .created = "CREATED",
        .running = "RUNNING",
        .aborting = "ABORTING",
        .aborted = "ABORTED",
        .completing = "COMPLETING",
        .completed = "COMPLETED",
        .failing = "FAILING",
        .failed = "FAILED",
        .partial = "PARTIAL",
        .aggregate_all = "AGGREGATE_ALL",
        .any = "ANY",
    };
};
