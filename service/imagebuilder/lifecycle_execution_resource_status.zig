pub const LifecycleExecutionResourceStatus = enum {
    failed,
    in_progress,
    skipped,
    success,

    pub const json_field_names = .{
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .skipped = "SKIPPED",
        .success = "SUCCESS",
    };
};
