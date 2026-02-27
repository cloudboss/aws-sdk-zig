pub const DataReplicationInitiationStepStatus = enum {
    not_started,
    in_progress,
    succeeded,
    failed,
    skipped,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .skipped = "SKIPPED",
    };
};
