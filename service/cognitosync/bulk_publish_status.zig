pub const BulkPublishStatus = enum {
    not_started,
    in_progress,
    failed,
    succeeded,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
