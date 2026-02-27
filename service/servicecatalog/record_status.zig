pub const RecordStatus = enum {
    created,
    in_progress,
    in_progress_in_error,
    succeeded,
    failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .in_progress_in_error = "IN_PROGRESS_IN_ERROR",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
