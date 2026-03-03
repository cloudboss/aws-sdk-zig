const RecommendationJobType = @import("recommendation_job_type.zig").RecommendationJobType;
const RecommendationJobStatus = @import("recommendation_job_status.zig").RecommendationJobStatus;

/// A structure that contains a list of recommendation jobs.
pub const InferenceRecommendationsJob = struct {
    /// A timestamp that shows when the job completed.
    completion_time: ?i64 = null,

    /// A timestamp that shows when the job was created.
    creation_time: i64,

    /// If the job fails, provides information why the job failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the recommendation job.
    job_arn: []const u8,

    /// The job description.
    job_description: []const u8,

    /// The name of the job.
    job_name: []const u8,

    /// The recommendation job type.
    job_type: RecommendationJobType,

    /// A timestamp that shows when the job was last modified.
    last_modified_time: i64,

    /// The name of the created model.
    model_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a versioned model package.
    model_package_version_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// to perform tasks on your behalf.
    role_arn: []const u8,

    /// The Amazon Simple Storage Service (Amazon S3) path where the sample payload
    /// is stored. This path must point to a single gzip compressed tar archive
    /// (.tar.gz suffix).
    sample_payload_url: ?[]const u8 = null,

    /// The status of the job.
    status: RecommendationJobStatus,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .job_arn = "JobArn",
        .job_description = "JobDescription",
        .job_name = "JobName",
        .job_type = "JobType",
        .last_modified_time = "LastModifiedTime",
        .model_name = "ModelName",
        .model_package_version_arn = "ModelPackageVersionArn",
        .role_arn = "RoleArn",
        .sample_payload_url = "SamplePayloadUrl",
        .status = "Status",
    };
};
