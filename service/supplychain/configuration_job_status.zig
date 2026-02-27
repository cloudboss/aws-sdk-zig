/// The status of the job.
pub const ConfigurationJobStatus = enum {
    new,
    failed,
    in_progress,
    queued,
    success,

    pub const json_field_names = .{
        .new = "NEW",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .queued = "QUEUED",
        .success = "SUCCESS",
    };
};
