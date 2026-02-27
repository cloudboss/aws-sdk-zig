/// If this job failed, this element indicates why the job failed.
pub const JobFailure = struct {
    /// The failure code, if any, for the specified job.
    failure_code: ?[]const u8,

    /// The failure reason, if any, for the specified job.
    failure_reason: ?[]const u8,
};
