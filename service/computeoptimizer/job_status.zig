pub const JobStatus = enum {
    queued,
    in_progress,
    complete,
    failed,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
    };
};
