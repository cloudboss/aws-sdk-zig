pub const JobStatus = enum {
    in_progress,
    succeeded,
    failed,
    canceled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .canceled = "CANCELED",
    };
};
