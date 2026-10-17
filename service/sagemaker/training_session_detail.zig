const BillableTokenUsage = @import("billable_token_usage.zig").BillableTokenUsage;
const LoraConfig = @import("lora_config.zig").LoraConfig;
const TrainingSessionModelConfig = @import("training_session_model_config.zig").TrainingSessionModelConfig;
const TrainingSessionOutputConfig = @import("training_session_output_config.zig").TrainingSessionOutputConfig;
const Tag = @import("tag.zig").Tag;
const TrainingSessionStatus = @import("training_session_status.zig").TrainingSessionStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Contains detailed information about a training session.
pub const TrainingSessionDetail = struct {
    /// The billable token usage for the training session.
    billable_token_usage: ?BillableTokenUsage = null,

    /// The date and time that the training session was created.
    creation_time: i64,

    /// The date and time that the training session ended.
    end_time: ?i64 = null,

    /// If the training session failed or is blocked, detailed error information.
    error_details: ?[]const u8 = null,

    /// The date and time that the training session was last modified.
    last_modified_time: ?i64 = null,

    /// The sequence number of the last training operation received by the session.
    last_received_sequence_number: ?i32 = null,

    /// The Low-Rank Adaptation (LoRA) configuration for the training session.
    lora_config: ?LoraConfig = null,

    /// The configuration for the base model.
    model_config: ?TrainingSessionModelConfig = null,

    /// The Amazon Resource Name (ARN) of the model package group where checkpoints
    /// are published.
    model_package_group_arn: ?[]const u8 = null,

    /// The output configuration for the training session.
    output_config: ?TrainingSessionOutputConfig = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the training
    /// session.
    role_arn: ?[]const u8 = null,

    /// The tags associated with the training session.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the training session.
    training_session_arn: []const u8,

    /// The name of the training session.
    training_session_name: []const u8,

    /// The current status of the training session.
    training_session_status: TrainingSessionStatus,

    /// The Virtual Private Cloud (VPC) configuration for the training session.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .billable_token_usage = "BillableTokenUsage",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .error_details = "ErrorDetails",
        .last_modified_time = "LastModifiedTime",
        .last_received_sequence_number = "LastReceivedSequenceNumber",
        .lora_config = "LoraConfig",
        .model_config = "ModelConfig",
        .model_package_group_arn = "ModelPackageGroupArn",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .training_session_arn = "TrainingSessionArn",
        .training_session_name = "TrainingSessionName",
        .training_session_status = "TrainingSessionStatus",
        .vpc_config = "VpcConfig",
    };
};
