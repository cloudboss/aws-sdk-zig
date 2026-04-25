/// An object that represents summary details for the first `RUNNABLE` job in a
/// quota share.
pub const FrontOfQuotaShareJobSummary = struct {
    /// The Unix timestamp (in milliseconds) for when the job transitioned to its
    /// current position in the quota share.
    earliest_time_at_position: ?i64 = null,

    /// The ARN for a job in a named quota share.
    job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .earliest_time_at_position = "earliestTimeAtPosition",
        .job_arn = "jobArn",
    };
};
