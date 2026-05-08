/// An online evaluation configuration associated with a specific A/B test
/// variant.
pub const PerVariantOnlineEvaluationConfig = struct {
    /// The name of the variant this evaluation configuration applies to.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the online evaluation configuration for
    /// this variant.
    online_evaluation_config_arn: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .online_evaluation_config_arn = "onlineEvaluationConfigArn",
    };
};
