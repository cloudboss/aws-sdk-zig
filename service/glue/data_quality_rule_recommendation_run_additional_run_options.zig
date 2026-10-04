/// Additional run options you can specify for a recommendation run.
pub const DataQualityRuleRecommendationRunAdditionalRunOptions = struct {
    /// A custom prefix for the CloudWatch log group names. When specified,
    /// recommendation run logs are written to `/error` and `/output` instead of the
    /// default `/aws-glue/data-quality/error` and `/aws-glue/data-quality/output`
    /// log groups.
    custom_log_group_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_log_group_prefix = "CustomLogGroupPrefix",
    };
};
