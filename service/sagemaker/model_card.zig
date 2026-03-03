const UserContext = @import("user_context.zig").UserContext;
const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;
const ModelCardSecurityConfig = @import("model_card_security_config.zig").ModelCardSecurityConfig;
const Tag = @import("tag.zig").Tag;

/// An Amazon SageMaker Model Card.
pub const ModelCard = struct {
    /// The content of the model card. Content uses the [model card JSON
    /// schema](https://docs.aws.amazon.com/sagemaker/latest/dg/model-cards.html#model-cards-json-schema) and provided as a string.
    content: ?[]const u8 = null,

    created_by: ?UserContext = null,

    /// The date and time that the model card was created.
    creation_time: ?i64 = null,

    last_modified_by: ?UserContext = null,

    /// The date and time that the model card was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model card.
    model_card_arn: ?[]const u8 = null,

    /// The unique name of the model card.
    model_card_name: ?[]const u8 = null,

    /// The approval status of the model card within your organization. Different
    /// organizations might have different criteria for model card review and
    /// approval.
    ///
    /// * `Draft`: The model card is a work in progress.
    /// * `PendingReview`: The model card is pending review.
    /// * `Approved`: The model card is approved.
    /// * `Archived`: The model card is archived. No more updates should be made to
    ///   the model card, but it can still be exported.
    model_card_status: ?ModelCardStatus = null,

    /// The version of the model card.
    model_card_version: ?i32 = null,

    /// The unique name (ID) of the model.
    model_id: ?[]const u8 = null,

    /// The model package group that contains the model package. Only relevant for
    /// model cards created for model packages in the Amazon SageMaker Model
    /// Registry.
    model_package_group_name: ?[]const u8 = null,

    /// The risk rating of the model. Different organizations might have different
    /// criteria for model card risk ratings. For more information, see [Risk
    /// ratings](https://docs.aws.amazon.com/sagemaker/latest/dg/model-cards-risk-rating.html).
    risk_rating: ?[]const u8 = null,

    /// The security configuration used to protect model card data.
    security_config: ?ModelCardSecurityConfig = null,

    /// Key-value pairs used to manage metadata for the model card.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .content = "Content",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .model_card_arn = "ModelCardArn",
        .model_card_name = "ModelCardName",
        .model_card_status = "ModelCardStatus",
        .model_card_version = "ModelCardVersion",
        .model_id = "ModelId",
        .model_package_group_name = "ModelPackageGroupName",
        .risk_rating = "RiskRating",
        .security_config = "SecurityConfig",
        .tags = "Tags",
    };
};
