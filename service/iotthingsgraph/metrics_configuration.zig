/// An object that specifies whether cloud metrics are collected in a deployment
/// and, if so, what role is used to collect metrics.
pub const MetricsConfiguration = struct {
    /// A Boolean that specifies whether cloud metrics are collected.
    cloud_metric_enabled: bool = false,

    /// The ARN of the role that is used to collect cloud metrics.
    metric_rule_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_metric_enabled = "cloudMetricEnabled",
        .metric_rule_role_arn = "metricRuleRoleArn",
    };
};
