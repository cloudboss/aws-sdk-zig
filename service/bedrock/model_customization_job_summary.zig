const CustomizationType = @import("customization_type.zig").CustomizationType;
const ModelCustomizationJobStatus = @import("model_customization_job_status.zig").ModelCustomizationJobStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;

/// Information about one customization job
pub const ModelCustomizationJobSummary = struct {
    /// Amazon Resource Name (ARN) of the base model.
    base_model_arn: []const u8,

    /// Creation time of the custom model.
    creation_time: i64,

    /// Specifies whether to carry out continued pre-training of a model or whether
    /// to fine-tune it. For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html).
    customization_type: ?CustomizationType,

    /// Amazon Resource Name (ARN) of the custom model.
    custom_model_arn: ?[]const u8,

    /// Name of the custom model.
    custom_model_name: ?[]const u8,

    /// Time that the customization job ended.
    end_time: ?i64,

    /// Amazon Resource Name (ARN) of the customization job.
    job_arn: []const u8,

    /// Name of the customization job.
    job_name: []const u8,

    /// Time that the customization job was last modified.
    last_modified_time: ?i64,

    /// Status of the customization job.
    status: ModelCustomizationJobStatus,

    /// Details about the status of the data processing sub-task of the job.
    status_details: ?StatusDetails,

    pub const json_field_names = .{
        .base_model_arn = "baseModelArn",
        .creation_time = "creationTime",
        .customization_type = "customizationType",
        .custom_model_arn = "customModelArn",
        .custom_model_name = "customModelName",
        .end_time = "endTime",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .last_modified_time = "lastModifiedTime",
        .status = "status",
        .status_details = "statusDetails",
    };
};
