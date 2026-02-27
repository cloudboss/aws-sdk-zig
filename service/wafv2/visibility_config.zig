/// Defines and enables Amazon CloudWatch metrics and web request sample
/// collection.
pub const VisibilityConfig = struct {
    /// Indicates whether the associated resource sends metrics to Amazon
    /// CloudWatch. For the
    /// list of available metrics, see [WAF
    /// Metrics](https://docs.aws.amazon.com/waf/latest/developerguide/monitoring-cloudwatch.html#waf-metrics) in the *WAF Developer Guide*.
    ///
    /// For web ACLs, the metrics are for web requests that have the web ACL default
    /// action applied.
    /// WAF applies the default action to web requests that pass the inspection of
    /// all rules
    /// in the web ACL without being either allowed or blocked. For more
    /// information,
    /// see [The web ACL default
    /// action](https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-default-action.html) in the *WAF Developer Guide*.
    cloud_watch_metrics_enabled: bool = false,

    /// A name of the Amazon CloudWatch metric dimension. The name can contain only
    /// the characters: A-Z, a-z, 0-9,
    /// - (hyphen), and _ (underscore). The name can be from one to 128 characters
    /// long. It can't
    /// contain whitespace or metric names that are reserved for WAF, for example
    /// `All` and
    /// `Default_Action`.
    metric_name: []const u8,

    /// Indicates whether WAF should store a sampling of the web requests that
    /// match the rules. You can view the sampled requests through the WAF console.
    ///
    /// If you configure data protection for the web ACL, the protection applies to
    /// the web ACL's sampled web request data.
    ///
    /// Request sampling doesn't provide a field redaction option, and any field
    /// redaction that you specify in your logging configuration doesn't affect
    /// sampling.
    /// You can only exclude fields from request sampling by disabling sampling in
    /// the web ACL visibility configuration
    /// or by configuring data protection for the web ACL.
    sampled_requests_enabled: bool = false,

    pub const json_field_names = .{
        .cloud_watch_metrics_enabled = "CloudWatchMetricsEnabled",
        .metric_name = "MetricName",
        .sampled_requests_enabled = "SampledRequestsEnabled",
    };
};
