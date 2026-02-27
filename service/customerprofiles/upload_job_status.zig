pub const UploadJobStatus = enum {
    created,
    in_progress,
    partially_succeeded,
    succeeded,
    failed,
    stopped,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
