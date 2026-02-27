const JobExecutionStatus = @import("job_execution_status.zig").JobExecutionStatus;
const JobExecutionStatusDetails = @import("job_execution_status_details.zig").JobExecutionStatusDetails;

/// The job execution object represents the execution of a job on a particular
/// device.
pub const JobExecution = struct {
    /// The estimated number of seconds that remain before the job execution status
    /// will be
    /// changed to `TIMED_OUT`. The timeout interval can be anywhere between 1
    /// minute
    /// and 7 days (1 to 10080 minutes). The actual job execution timeout can occur
    /// up to 60
    /// seconds later than the estimated duration. This value will not be included
    /// if the job
    /// execution has reached a terminal status.
    approximate_seconds_before_timed_out: ?i64,

    /// A string (consisting of the digits "0" through "9") which identifies this
    /// particular job execution on this particular device. It can be used in
    /// commands which
    /// return or update job execution information.
    execution_number: ?i64,

    /// Will be `true` if the job execution was canceled with the optional
    /// `force` parameter set to `true`.
    force_canceled: ?bool,

    /// The unique identifier you assigned to the job when it was created.
    job_id: ?[]const u8,

    /// The time, in seconds since the epoch, when the job execution was last
    /// updated.
    last_updated_at: ?i64,

    /// The time, in seconds since the epoch, when the job execution was queued.
    queued_at: ?i64,

    /// The time, in seconds since the epoch, when the job execution started.
    started_at: ?i64,

    /// The status of the job execution (IN_PROGRESS, QUEUED, FAILED, SUCCEEDED,
    /// TIMED_OUT,
    /// CANCELED, or REJECTED).
    status: ?JobExecutionStatus,

    /// A collection of name/value pairs that describe the status of the job
    /// execution.
    status_details: ?JobExecutionStatusDetails,

    /// The ARN of the thing on which the job execution is running.
    thing_arn: ?[]const u8,

    /// The version of the job execution. Job execution versions are incremented
    /// each time
    /// they are updated by a device.
    version_number: i64 = 0,

    pub const json_field_names = .{
        .approximate_seconds_before_timed_out = "approximateSecondsBeforeTimedOut",
        .execution_number = "executionNumber",
        .force_canceled = "forceCanceled",
        .job_id = "jobId",
        .last_updated_at = "lastUpdatedAt",
        .queued_at = "queuedAt",
        .started_at = "startedAt",
        .status = "status",
        .status_details = "statusDetails",
        .thing_arn = "thingArn",
        .version_number = "versionNumber",
    };
};
