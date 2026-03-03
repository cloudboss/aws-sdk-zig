/// An object that represents summary details for the first 100 `RUNNABLE` jobs
/// in a job queue.
pub const FrontOfQueueJobSummary = struct {
    /// The Unix timestamp (in milliseconds) for when the job transitioned to its
    /// current position in the job queue.
    earliest_time_at_position: ?i64 = null,

    /// The ARN for a job in a named job queue.
    job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .earliest_time_at_position = "earliestTimeAtPosition",
        .job_arn = "jobArn",
    };
};
