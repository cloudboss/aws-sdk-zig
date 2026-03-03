const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The model registry settings for the SageMaker Canvas application.
pub const ModelRegisterSettings = struct {
    /// The Amazon Resource Name (ARN) of the SageMaker model registry account.
    /// Required only to register model versions created by a different SageMaker
    /// Canvas Amazon Web Services account than the Amazon Web Services account in
    /// which SageMaker model registry is set up.
    cross_account_model_register_role_arn: ?[]const u8 = null,

    /// Describes whether the integration to the model registry is enabled or
    /// disabled in the Canvas application.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .cross_account_model_register_role_arn = "CrossAccountModelRegisterRoleArn",
        .status = "Status",
    };
};
