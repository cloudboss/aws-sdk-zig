const aws = @import("aws");

const JobExecutionStatus = @import("job_execution_status.zig").JobExecutionStatus;

/// Contains data about a job execution.
pub const JobExecution = struct {
    /// The estimated number of seconds that remain before the job execution status
    /// will be
    /// changed to `TIMED_OUT`. The actual job execution timeout can occur up to 60
    /// seconds later than the estimated duration.
    approximate_seconds_before_timed_out: ?i64 = null,

    /// A number that identifies a particular job execution on a particular device.
    /// It can be
    /// used later in commands that return or update job execution information.
    execution_number: ?i64 = null,

    /// The content of the job document.
    job_document: ?[]const u8 = null,

    /// The unique identifier you assigned to this job when it was created.
    job_id: ?[]const u8 = null,

    /// The time, in seconds since the epoch, when the job execution was last
    /// updated.
    last_updated_at: i64 = 0,

    /// The time, in seconds since the epoch, when the job execution was enqueued.
    queued_at: i64 = 0,

    /// The time, in seconds since the epoch, when the job execution was started.
    started_at: ?i64 = null,

    /// The status of the job execution. Can be one of: "QUEUED", "IN_PROGRESS",
    /// "FAILED",
    /// "SUCCESS", "CANCELED", "TIMED_OUT", "REJECTED", or "REMOVED".
    status: ?JobExecutionStatus = null,

    /// A collection of name/value pairs that describe the status of the job
    /// execution.
    ///
    /// The maximum length of the value in the name/value pair is 1,024 characters.
    status_details: ?[]const aws.map.StringMapEntry = null,

    /// The name of the thing that is executing the job.
    thing_name: ?[]const u8 = null,

    /// The version of the job execution. Job execution versions are incremented
    /// each time
    /// they are updated by a device.
    version_number: i64 = 0,

    pub const json_field_names = .{
        .approximate_seconds_before_timed_out = "approximateSecondsBeforeTimedOut",
        .execution_number = "executionNumber",
        .job_document = "jobDocument",
        .job_id = "jobId",
        .last_updated_at = "lastUpdatedAt",
        .queued_at = "queuedAt",
        .started_at = "startedAt",
        .status = "status",
        .status_details = "statusDetails",
        .thing_name = "thingName",
        .version_number = "versionNumber",
    };
};
