/// An execution property of a job.
pub const ExecutionProperty = struct {
    /// The maximum number of concurrent runs allowed for the job.
    /// The default is 1. An error is returned when this threshold is reached.
    /// The maximum value you can specify is controlled by a service limit.
    max_concurrent_runs: i32 = 0,

    pub const json_field_names = .{
        .max_concurrent_runs = "MaxConcurrentRuns",
    };
};
