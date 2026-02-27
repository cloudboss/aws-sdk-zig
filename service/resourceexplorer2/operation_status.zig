pub const OperationStatus = enum {
    succeeded,
    failed,
    in_progress,
    skipped,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .skipped = "SKIPPED",
    };
};
