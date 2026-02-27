/// A truncated version of the
/// [BatchSegmentJob](https://docs.aws.amazon.com/personalize/latest/dg/API_BatchSegmentJob.html) datatype.
/// [ListBatchSegmentJobs](https://docs.aws.amazon.com/personalize/latest/dg/API_ListBatchSegmentJobs.html) operation returns a list of batch segment job
/// summaries.
pub const BatchSegmentJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the batch segment job.
    batch_segment_job_arn: ?[]const u8,

    /// The time at which the batch segment job was created.
    creation_date_time: ?i64,

    /// If the batch segment job failed, the reason for the failure.
    failure_reason: ?[]const u8,

    /// The name of the batch segment job.
    job_name: ?[]const u8,

    /// The time at which the batch segment job was last updated.
    last_updated_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the solution version used by the batch
    /// segment job to generate batch segments.
    solution_version_arn: ?[]const u8,

    /// The status of the batch segment job. The status is one of the following
    /// values:
    ///
    /// * PENDING
    ///
    /// * IN PROGRESS
    ///
    /// * ACTIVE
    ///
    /// * CREATE FAILED
    status: ?[]const u8,

    pub const json_field_names = .{
        .batch_segment_job_arn = "batchSegmentJobArn",
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .job_name = "jobName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .solution_version_arn = "solutionVersionArn",
        .status = "status",
    };
};
