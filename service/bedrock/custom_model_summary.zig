const CustomizationType = @import("customization_type.zig").CustomizationType;
const ModelStatus = @import("model_status.zig").ModelStatus;

/// Summary information for a custom model.
pub const CustomModelSummary = struct {
    /// The base model Amazon Resource Name (ARN).
    base_model_arn: []const u8,

    /// The base model name.
    base_model_name: []const u8,

    /// Creation time of the model.
    creation_time: i64,

    /// Specifies whether to carry out continued pre-training of a model or whether
    /// to fine-tune it. For more information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html).
    customization_type: ?CustomizationType,

    /// The Amazon Resource Name (ARN) of the custom model.
    model_arn: []const u8,

    /// The name of the custom model.
    model_name: []const u8,

    /// The current status of the custom model. Possible values include:
    ///
    /// * `Creating` - The model is being created and validated.
    /// * `Active` - The model has been successfully created and is ready for use.
    /// * `Failed` - The model creation process failed.
    model_status: ?ModelStatus,

    /// The unique identifier of the account that owns the model.
    owner_account_id: ?[]const u8,

    pub const json_field_names = .{
        .base_model_arn = "baseModelArn",
        .base_model_name = "baseModelName",
        .creation_time = "creationTime",
        .customization_type = "customizationType",
        .model_arn = "modelArn",
        .model_name = "modelName",
        .model_status = "modelStatus",
        .owner_account_id = "ownerAccountId",
    };
};
