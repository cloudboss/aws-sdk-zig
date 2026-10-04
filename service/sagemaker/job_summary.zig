const JobCategory = @import("job_category.zig").JobCategory;
const JobSecondaryStatus = @import("job_secondary_status.zig").JobSecondaryStatus;
const JobStatus = @import("job_status.zig").JobStatus;

/// Provides summary information about a job, returned by the `ListJobs`
/// operation. Use `DescribeJob` to get full details for a specific job.
pub const JobSummary = struct {
    /// The date and time that the job was created.
    creation_time: i64,

    /// The date and time that the job ended.
    end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: []const u8,

    /// The category of the job.
    job_category: JobCategory,

    /// The name of the job.
    job_name: []const u8,

    /// The secondary status of the job, providing more granular information about
    /// the job's progress. Secondary statuses may change between releases.
    job_secondary_status: JobSecondaryStatus,

    /// The current status of the job.
    job_status: JobStatus,

    /// The date and time that the job was last modified.
    last_modified_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .job_arn = "JobArn",
        .job_category = "JobCategory",
        .job_name = "JobName",
        .job_secondary_status = "JobSecondaryStatus",
        .job_status = "JobStatus",
        .last_modified_time = "LastModifiedTime",
    };
};
