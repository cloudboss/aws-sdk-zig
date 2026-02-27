/// Contains a subset of information about a job execution.
pub const JobExecutionSummary = struct {
    /// A number that identifies a particular job execution on a particular device.
    execution_number: ?i64,

    /// The unique identifier you assigned to this job when it was created.
    job_id: ?[]const u8,

    /// The time, in seconds since the epoch, when the job execution was last
    /// updated.
    last_updated_at: i64 = 0,

    /// The time, in seconds since the epoch, when the job execution was enqueued.
    queued_at: i64 = 0,

    /// The time, in seconds since the epoch, when the job execution started.
    started_at: ?i64,

    /// The version of the job execution. Job execution versions are incremented
    /// each time
    /// IoT Jobs receives an update from a device.
    version_number: i64 = 0,

    pub const json_field_names = .{
        .execution_number = "executionNumber",
        .job_id = "jobId",
        .last_updated_at = "lastUpdatedAt",
        .queued_at = "queuedAt",
        .started_at = "startedAt",
        .version_number = "versionNumber",
    };
};
