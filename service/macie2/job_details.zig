const IsDefinedInJob = @import("is_defined_in_job.zig").IsDefinedInJob;
const IsMonitoredByJob = @import("is_monitored_by_job.zig").IsMonitoredByJob;

/// Specifies whether any one-time or recurring classification jobs are
/// configured to analyze objects in an S3 bucket, and, if so, the details of
/// the job that ran most recently.
pub const JobDetails = struct {
    /// Specifies whether any one-time or recurring jobs are configured to analyze
    /// objects in the bucket. Possible values are:
    ///
    /// * TRUE - The bucket is explicitly included in the bucket definition
    ///   (S3BucketDefinitionForJob) for one or more jobs and at least one of those
    ///   jobs has a status other than CANCELLED. Or the bucket matched the bucket
    ///   criteria (S3BucketCriteriaForJob) for at least one job that previously
    ///   ran.
    /// * FALSE - The bucket isn't explicitly included in the bucket definition
    ///   (S3BucketDefinitionForJob) for any jobs, all the jobs that explicitly
    ///   include the bucket in their bucket definitions have a status of CANCELLED,
    ///   or the bucket didn't match the bucket criteria (S3BucketCriteriaForJob)
    ///   for any jobs that previously ran.
    /// * UNKNOWN - An exception occurred when Amazon Macie attempted to retrieve
    ///   job data for the bucket.
    is_defined_in_job: ?IsDefinedInJob = null,

    /// Specifies whether any recurring jobs are configured to analyze objects in
    /// the bucket. Possible values are:
    ///
    /// * TRUE - The bucket is explicitly included in the bucket definition
    ///   (S3BucketDefinitionForJob) for one or more recurring jobs or the bucket
    ///   matches the bucket criteria (S3BucketCriteriaForJob) for one or more
    ///   recurring jobs. At least one of those jobs has a status other than
    ///   CANCELLED.
    /// * FALSE - The bucket isn't explicitly included in the bucket definition
    ///   (S3BucketDefinitionForJob) for any recurring jobs, the bucket doesn't
    ///   match the bucket criteria (S3BucketCriteriaForJob) for any recurring jobs,
    ///   or all the recurring jobs that are configured to analyze data in the
    ///   bucket have a status of CANCELLED.
    /// * UNKNOWN - An exception occurred when Amazon Macie attempted to retrieve
    ///   job data for the bucket.
    is_monitored_by_job: ?IsMonitoredByJob = null,

    /// The unique identifier for the job that ran most recently and is configured
    /// to analyze objects in the bucket, either the latest run of a recurring job
    /// or the only run of a one-time job.
    ///
    /// This value is typically null if the value for the isDefinedInJob property is
    /// FALSE or UNKNOWN.
    last_job_id: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the job
    /// (lastJobId) started. If the job is a recurring job, this value indicates
    /// when the most recent run started.
    ///
    /// This value is typically null if the value for the isDefinedInJob property is
    /// FALSE or UNKNOWN.
    last_job_run_time: ?i64 = null,

    pub const json_field_names = .{
        .is_defined_in_job = "isDefinedInJob",
        .is_monitored_by_job = "isMonitoredByJob",
        .last_job_id = "lastJobId",
        .last_job_run_time = "lastJobRunTime",
    };
};
