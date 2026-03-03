const JobStatus = @import("job_status.zig").JobStatus;
const TargetSelection = @import("target_selection.zig").TargetSelection;

/// The job summary.
pub const JobSummary = struct {
    /// The time, in seconds since the epoch, when the job completed.
    completed_at: ?i64 = null,

    /// The time, in seconds since the epoch, when the job was created.
    created_at: ?i64 = null,

    /// Indicates whether a job is concurrent. Will be true when a job is rolling
    /// out new job
    /// executions or canceling previously created executions, otherwise false.
    is_concurrent: ?bool = null,

    /// The job ARN.
    job_arn: ?[]const u8 = null,

    /// The unique identifier you assigned to this job when it was created.
    job_id: ?[]const u8 = null,

    /// The time, in seconds since the epoch, when the job was last updated.
    last_updated_at: ?i64 = null,

    /// The job summary status.
    status: ?JobStatus = null,

    /// Specifies whether the job will continue to run (CONTINUOUS), or will be
    /// complete
    /// after all those things specified as targets have completed the job
    /// (SNAPSHOT). If
    /// continuous, the job may also be run on a thing when a change is detected in
    /// a target.
    /// For example, a job will run on a thing when the thing is added to a target
    /// group, even
    /// after the job was completed by all things originally in the group.
    ///
    /// We recommend that you use continuous jobs instead of snapshot jobs for
    /// dynamic
    /// thing group targets. By using continuous jobs, devices that join the group
    /// receive
    /// the job execution even after the job has been created.
    target_selection: ?TargetSelection = null,

    /// The ID of the thing group.
    thing_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .is_concurrent = "isConcurrent",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
        .target_selection = "targetSelection",
        .thing_group_id = "thingGroupId",
    };
};
