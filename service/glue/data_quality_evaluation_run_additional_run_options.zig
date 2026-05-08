const DQCompositeRuleEvaluationMethod = @import("dq_composite_rule_evaluation_method.zig").DQCompositeRuleEvaluationMethod;

/// Additional run options you can specify for an evaluation run.
pub const DataQualityEvaluationRunAdditionalRunOptions = struct {
    /// Whether or not to enable CloudWatch metrics.
    cloud_watch_metrics_enabled: ?bool = null,

    /// Set the evaluation method for composite rules in the ruleset to ROW/COLUMN
    composite_rule_evaluation_method: ?DQCompositeRuleEvaluationMethod = null,

    /// A custom prefix for the CloudWatch log group names. When specified,
    /// evaluation run logs are written to `/error` and `/output` instead of the
    /// default `/aws-glue/data-quality/error` and `/aws-glue/data-quality/output`
    /// log groups.
    custom_log_group_prefix: ?[]const u8 = null,

    /// Prefix for Amazon S3 to store results.
    results_s3_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_metrics_enabled = "CloudWatchMetricsEnabled",
        .composite_rule_evaluation_method = "CompositeRuleEvaluationMethod",
        .custom_log_group_prefix = "CustomLogGroupPrefix",
        .results_s3_prefix = "ResultsS3Prefix",
    };
};
