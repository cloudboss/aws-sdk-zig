const JobExecutionStatus = @import("job_execution_status.zig").JobExecutionStatus;

/// The job execution summary.
pub const JobExecutionSummary = struct {
    /// A string (consisting of the digits "0" through "9") which identifies this
    /// particular job execution on this particular device. It can be used later in
    /// commands
    /// which return or update job execution information.
    execution_number: ?i64 = null,

    /// The time, in seconds since the epoch, when the job execution was last
    /// updated.
    last_updated_at: ?i64 = null,

    /// The time, in seconds since the epoch, when the job execution was queued.
    queued_at: ?i64 = null,

    /// The number that indicates how many retry attempts have been completed for
    /// this job on
    /// this device.
    retry_attempt: ?i32 = null,

    /// The time, in seconds since the epoch, when the job execution started.
    started_at: ?i64 = null,

    /// The status of the job execution.
    status: ?JobExecutionStatus = null,

    pub const json_field_names = .{
        .execution_number = "executionNumber",
        .last_updated_at = "lastUpdatedAt",
        .queued_at = "queuedAt",
        .retry_attempt = "retryAttempt",
        .started_at = "startedAt",
        .status = "status",
    };
};
