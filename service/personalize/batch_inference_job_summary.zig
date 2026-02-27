const BatchInferenceJobMode = @import("batch_inference_job_mode.zig").BatchInferenceJobMode;

/// A truncated version of the
/// [BatchInferenceJob](https://docs.aws.amazon.com/personalize/latest/dg/API_BatchInferenceJob.html). The
/// [ListBatchInferenceJobs](https://docs.aws.amazon.com/personalize/latest/dg/API_ListBatchInferenceJobs.html) operation returns a list of batch inference job
/// summaries.
pub const BatchInferenceJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the batch inference job.
    batch_inference_job_arn: ?[]const u8,

    /// The job's mode.
    batch_inference_job_mode: ?BatchInferenceJobMode,

    /// The time at which the batch inference job was created.
    creation_date_time: ?i64,

    /// If the batch inference job failed, the reason for the failure.
    failure_reason: ?[]const u8,

    /// The name of the batch inference job.
    job_name: ?[]const u8,

    /// The time at which the batch inference job was last updated.
    last_updated_date_time: ?i64,

    /// The ARN of the solution version used by the batch inference job.
    solution_version_arn: ?[]const u8,

    /// The status of the batch inference job. The status is one of the following
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
        .batch_inference_job_arn = "batchInferenceJobArn",
        .batch_inference_job_mode = "batchInferenceJobMode",
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .job_name = "jobName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .solution_version_arn = "solutionVersionArn",
        .status = "status",
    };
};
