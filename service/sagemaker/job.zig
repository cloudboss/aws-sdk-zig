const JobCategory = @import("job_category.zig").JobCategory;
const JobStatus = @import("job_status.zig").JobStatus;
const JobSecondaryStatus = @import("job_secondary_status.zig").JobSecondaryStatus;
const JobSecondaryStatusTransition = @import("job_secondary_status_transition.zig").JobSecondaryStatusTransition;
const Tag = @import("tag.zig").Tag;

/// The properties of a job returned by the
/// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API.
pub const Job = struct {
    /// The date and time that the job was created.
    creation_time: ?i64 = null,

    /// The date and time that the job ended.
    end_time: ?i64 = null,

    /// If the job failed, the reason it failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: ?[]const u8 = null,

    /// The category of the job.
    job_category: ?JobCategory = null,

    /// The JSON configuration document for the job.
    job_config_document: ?[]const u8 = null,

    /// The schema version used for the job configuration document.
    job_config_schema_version: ?[]const u8 = null,

    /// The name of the job.
    job_name: ?[]const u8 = null,

    /// The current status of the job.
    job_status: ?JobStatus = null,

    /// The date and time that the job was last modified.
    last_modified_time: ?i64 = null,

    /// The ARN of the IAM role associated with the job.
    role_arn: ?[]const u8 = null,

    /// The detailed secondary status of the job, providing more granular
    /// information about the job's progress.
    secondary_status: ?JobSecondaryStatus = null,

    /// A list of secondary status transitions for the job, with timestamps and
    /// optional status messages.
    secondary_status_transitions: ?[]const JobSecondaryStatusTransition = null,

    /// The tags associated with the job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .job_arn = "JobArn",
        .job_category = "JobCategory",
        .job_config_document = "JobConfigDocument",
        .job_config_schema_version = "JobConfigSchemaVersion",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .last_modified_time = "LastModifiedTime",
        .role_arn = "RoleArn",
        .secondary_status = "SecondaryStatus",
        .secondary_status_transitions = "SecondaryStatusTransitions",
        .tags = "Tags",
    };
};
