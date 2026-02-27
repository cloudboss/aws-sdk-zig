pub const ReadSetImportJobItemStatus = enum {
    not_started,
    in_progress,
    finished,
    failed,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .finished = "FINISHED",
        .failed = "FAILED",
    };
};
