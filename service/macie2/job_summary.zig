const S3BucketCriteriaForJob = @import("s3_bucket_criteria_for_job.zig").S3BucketCriteriaForJob;
const S3BucketDefinitionForJob = @import("s3_bucket_definition_for_job.zig").S3BucketDefinitionForJob;
const JobStatus = @import("job_status.zig").JobStatus;
const JobType = @import("job_type.zig").JobType;
const LastRunErrorStatus = @import("last_run_error_status.zig").LastRunErrorStatus;
const UserPausedDetails = @import("user_paused_details.zig").UserPausedDetails;

/// Provides information about a classification job, including the current
/// status of the job.
pub const JobSummary = struct {
    /// The property- and tag-based conditions that determine which S3 buckets are
    /// included or excluded from the job's analysis. Each time the job runs, the
    /// job uses these criteria to determine which buckets to analyze. A job's
    /// definition can contain a bucketCriteria object or a bucketDefinitions array,
    /// not both.
    bucket_criteria: ?S3BucketCriteriaForJob,

    /// An array of objects, one for each Amazon Web Services account that owns
    /// specific S3 buckets for the job to analyze. Each object specifies the
    /// account ID for an account and one or more buckets to analyze for that
    /// account. A job's definition can contain a bucketDefinitions array or a
    /// bucketCriteria object, not both.
    bucket_definitions: ?[]const S3BucketDefinitionForJob,

    /// The date and time, in UTC and extended ISO 8601 format, when the job was
    /// created.
    created_at: ?i64,

    /// The unique identifier for the job.
    job_id: ?[]const u8,

    /// The current status of the job. Possible values are:
    ///
    /// * CANCELLED - You cancelled the job or, if it's a one-time job, you paused
    ///   the job and didn't resume it within 30 days.
    /// * COMPLETE - For a one-time job, Amazon Macie finished processing the data
    ///   specified for the job. This value doesn't apply to recurring jobs.
    /// * IDLE - For a recurring job, the previous scheduled run is complete and the
    ///   next scheduled run is pending. This value doesn't apply to one-time jobs.
    /// * PAUSED - Macie started running the job but additional processing would
    ///   exceed the monthly sensitive data discovery quota for your account or one
    ///   or more member accounts that the job analyzes data for.
    /// * RUNNING - For a one-time job, the job is in progress. For a recurring job,
    ///   a scheduled run is in progress.
    /// * USER_PAUSED - You paused the job. If you paused the job while it had a
    ///   status of RUNNING and you don't resume it within 30 days of pausing it,
    ///   the job or job run will expire and be cancelled, depending on the job's
    ///   type. To check the expiration date, refer to the
    ///   UserPausedDetails.jobExpiresAt property.
    job_status: ?JobStatus,

    /// The schedule for running the job. Possible values are:
    ///
    /// * ONE_TIME - The job runs only once.
    /// * SCHEDULED - The job runs on a daily, weekly, or monthly basis.
    job_type: ?JobType,

    /// Specifies whether any account- or bucket-level access errors occurred when
    /// the job ran. For a recurring job, this value indicates the error status of
    /// the job's most recent run.
    last_run_error_status: ?LastRunErrorStatus,

    /// The custom name of the job.
    name: ?[]const u8,

    /// If the current status of the job is USER_PAUSED, specifies when the job was
    /// paused and when the job or job run will expire and be cancelled if it isn't
    /// resumed. This value is present only if the value for jobStatus is
    /// USER_PAUSED.
    user_paused_details: ?UserPausedDetails,

    pub const json_field_names = .{
        .bucket_criteria = "bucketCriteria",
        .bucket_definitions = "bucketDefinitions",
        .created_at = "createdAt",
        .job_id = "jobId",
        .job_status = "jobStatus",
        .job_type = "jobType",
        .last_run_error_status = "lastRunErrorStatus",
        .name = "name",
        .user_paused_details = "userPausedDetails",
    };
};
