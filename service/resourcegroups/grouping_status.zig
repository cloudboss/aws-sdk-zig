pub const GroupingStatus = enum {
    success,
    failed,
    in_progress,
    skipped,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .skipped = "SKIPPED",
    };
};
