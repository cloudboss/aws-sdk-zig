const AIMlflowConfig = @import("ai_mlflow_config.zig").AIMlflowConfig;

/// The output configuration for an AI recommendation job, including the S3
/// location for results and the model package group for deployment.
pub const AIRecommendationOutputResult = struct {
    /// The MLflow tracking configuration for the job.
    mlflow_config: ?AIMlflowConfig = null,

    /// The name or Amazon Resource Name (ARN) of the model package group where
    /// deployment-ready model packages are registered.
    model_package_group_identifier: ?[]const u8 = null,

    /// The Amazon S3 URI where the recommendation job writes its output results.
    s3_output_location: []const u8,

    pub const json_field_names = .{
        .mlflow_config = "MlflowConfig",
        .model_package_group_identifier = "ModelPackageGroupIdentifier",
        .s3_output_location = "S3OutputLocation",
    };
};
