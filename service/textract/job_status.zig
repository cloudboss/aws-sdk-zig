pub const JobStatus = enum {
    in_progress,
    succeeded,
    failed,
    partial_success,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .partial_success = "PARTIAL_SUCCESS",
    };
};
