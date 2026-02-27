const TransformJobStatus = @import("transform_job_status.zig").TransformJobStatus;

/// Provides a summary of a transform job. Multiple `TransformJobSummary`
/// objects are returned as a list after in response to a
/// [ListTransformJobs](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListTransformJobs.html) call.
pub const TransformJobSummary = struct {
    /// A timestamp that shows when the transform Job was created.
    creation_time: i64,

    /// If the transform job failed, the reason it failed.
    failure_reason: ?[]const u8,

    /// Indicates when the transform job was last modified.
    last_modified_time: ?i64,

    /// Indicates when the transform job ends on compute instances. For successful
    /// jobs and stopped jobs, this is the exact time recorded after the results are
    /// uploaded. For failed jobs, this is when Amazon SageMaker detected that the
    /// job failed.
    transform_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the transform job.
    transform_job_arn: []const u8,

    /// The name of the transform job.
    transform_job_name: []const u8,

    /// The status of the transform job.
    transform_job_status: TransformJobStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .transform_end_time = "TransformEndTime",
        .transform_job_arn = "TransformJobArn",
        .transform_job_name = "TransformJobName",
        .transform_job_status = "TransformJobStatus",
    };
};
