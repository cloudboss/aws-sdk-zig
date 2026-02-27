/// The retry strategy to use for failed jobs, if the target is an Batch job.
/// If you specify a retry strategy here, it overrides the retry strategy
/// defined in the job
/// definition.
pub const BatchRetryStrategy = struct {
    /// The number of times to attempt to retry, if the job fails. Valid values are
    /// 1–10.
    attempts: i32 = 0,

    pub const json_field_names = .{
        .attempts = "Attempts",
    };
};
