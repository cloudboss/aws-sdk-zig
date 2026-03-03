/// An object that represents a job timeout configuration.
pub const JobTimeout = struct {
    /// The job timeout time (in seconds) that's measured from the job attempt's
    /// `startedAt` timestamp. After this time passes, Batch terminates your jobs if
    /// they
    /// aren't finished. The minimum value for the timeout is 60 seconds.
    ///
    /// For array jobs, the timeout applies to the child jobs, not to the parent
    /// array job.
    ///
    /// For multi-node parallel (MNP) jobs, the timeout applies to the whole job,
    /// not to the
    /// individual nodes.
    attempt_duration_seconds: ?i32 = null,

    pub const json_field_names = .{
        .attempt_duration_seconds = "attemptDurationSeconds",
    };
};
