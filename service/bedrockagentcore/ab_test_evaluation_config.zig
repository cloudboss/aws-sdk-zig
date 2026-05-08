const PerVariantOnlineEvaluationConfig = @import("per_variant_online_evaluation_config.zig").PerVariantOnlineEvaluationConfig;

/// The evaluation configuration for an A/B test, specifying which online
/// evaluation configurations to use for measuring variant performance.
pub const ABTestEvaluationConfig = union(enum) {
    /// The Amazon Resource Name (ARN) of a single online evaluation configuration
    /// to use for both variants.
    online_evaluation_config_arn: ?[]const u8,
    /// Per-variant online evaluation configurations, allowing different evaluation
    /// settings for each variant.
    per_variant_online_evaluation_config: ?[]const PerVariantOnlineEvaluationConfig,

    pub const json_field_names = .{
        .online_evaluation_config_arn = "onlineEvaluationConfigArn",
        .per_variant_online_evaluation_config = "perVariantOnlineEvaluationConfig",
    };
};
