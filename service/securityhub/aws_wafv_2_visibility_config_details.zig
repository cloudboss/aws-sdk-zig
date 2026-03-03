/// Defines and enables Amazon CloudWatch metrics and web request sample
/// collection.
pub const AwsWafv2VisibilityConfigDetails = struct {
    /// A boolean indicating whether the associated resource sends metrics to Amazon
    /// CloudWatch. For the list of available
    /// metrics, see [WAF metrics and
    /// dimensions](https://docs.aws.amazon.com/waf/latest/developerguide/monitoring-cloudwatch.html#waf-metrics) in the *WAF Developer Guide*.
    cloud_watch_metrics_enabled: ?bool = null,

    /// A name of the Amazon CloudWatch metric.
    metric_name: ?[]const u8 = null,

    /// A boolean indicating whether WAF should store a sampling of the web requests
    /// that match the rules.
    /// You can view the sampled requests through the WAF console.
    sampled_requests_enabled: ?bool = null,

    pub const json_field_names = .{
        .cloud_watch_metrics_enabled = "CloudWatchMetricsEnabled",
        .metric_name = "MetricName",
        .sampled_requests_enabled = "SampledRequestsEnabled",
    };
};
