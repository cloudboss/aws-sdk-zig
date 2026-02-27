const ModelCopyJobStatus = @import("model_copy_job_status.zig").ModelCopyJobStatus;
const Tag = @import("tag.zig").Tag;

/// Contains details about each model copy job.
///
/// This data type is used in the following API operations:
///
/// * [ListModelCopyJobs
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListModelCopyJobs.html#API_ListModelCopyJobs_ResponseSyntax)
pub const ModelCopyJobSummary = struct {
    /// The time that the model copy job was created.
    creation_time: i64,

    /// If a model fails to be copied, a message describing why the job failed is
    /// included here.
    failure_message: ?[]const u8,

    /// The Amazon Resoource Name (ARN) of the model copy job.
    job_arn: []const u8,

    /// The unique identifier of the account that the model being copied originated
    /// from.
    source_account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the original model being copied.
    source_model_arn: []const u8,

    /// The name of the original model being copied.
    source_model_name: ?[]const u8,

    /// The status of the model copy job.
    status: ModelCopyJobStatus,

    /// The Amazon Resource Name (ARN) of the copied model.
    target_model_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the copied
    /// model.
    target_model_kms_key_arn: ?[]const u8,

    /// The name of the copied model.
    target_model_name: ?[]const u8,

    /// Tags associated with the copied model.
    target_model_tags: ?[]const Tag,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .failure_message = "failureMessage",
        .job_arn = "jobArn",
        .source_account_id = "sourceAccountId",
        .source_model_arn = "sourceModelArn",
        .source_model_name = "sourceModelName",
        .status = "status",
        .target_model_arn = "targetModelArn",
        .target_model_kms_key_arn = "targetModelKmsKeyArn",
        .target_model_name = "targetModelName",
        .target_model_tags = "targetModelTags",
    };
};
