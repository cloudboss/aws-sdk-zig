pub const RepositorySyncStatus = enum {
    failed,
    initiated,
    in_progress,
    succeeded,
    queued,

    pub const json_field_names = .{
        .failed = "FAILED",
        .initiated = "INITIATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .queued = "QUEUED",
    };
};
