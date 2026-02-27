pub const MediaAnalysisJobStatus = enum {
    created,
    queued,
    in_progress,
    succeeded,
    failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
