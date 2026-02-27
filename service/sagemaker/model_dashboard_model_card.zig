const UserContext = @import("user_context.zig").UserContext;
const ModelCardStatus = @import("model_card_status.zig").ModelCardStatus;
const ModelCardSecurityConfig = @import("model_card_security_config.zig").ModelCardSecurityConfig;
const Tag = @import("tag.zig").Tag;

/// The model card for a model displayed in the Amazon SageMaker Model
/// Dashboard.
pub const ModelDashboardModelCard = struct {
    created_by: ?UserContext,

    /// A timestamp that indicates when the model card was created.
    creation_time: ?i64,

    last_modified_by: ?UserContext,

    /// A timestamp that indicates when the model card was last updated.
    last_modified_time: ?i64,

    /// The Amazon Resource Name (ARN) for a model card.
    model_card_arn: ?[]const u8,

    /// The name of a model card.
    model_card_name: ?[]const u8,

    /// The model card status.
    model_card_status: ?ModelCardStatus,

    /// The model card version.
    model_card_version: ?i32,

    /// For models created in SageMaker, this is the model ARN. For models created
    /// outside of SageMaker, this is a user-customized string.
    model_id: ?[]const u8,

    /// A model card's risk rating. Can be low, medium, or high.
    risk_rating: ?[]const u8,

    /// The KMS Key ID (`KMSKeyId`) for encryption of model card information.
    security_config: ?ModelCardSecurityConfig,

    /// The tags associated with a model card.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .model_card_arn = "ModelCardArn",
        .model_card_name = "ModelCardName",
        .model_card_status = "ModelCardStatus",
        .model_card_version = "ModelCardVersion",
        .model_id = "ModelId",
        .risk_rating = "RiskRating",
        .security_config = "SecurityConfig",
        .tags = "Tags",
    };
};
