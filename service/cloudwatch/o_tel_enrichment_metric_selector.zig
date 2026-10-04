/// Selects the metrics in one namespace, for use in the `IncludeFilters` or
/// `ExcludeFilters` parameter of
/// [StartOTelEnrichment](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_StartOTelEnrichment.html) or [UpdateOTelEnrichment](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_UpdateOTelEnrichment.html).
///
/// A maximum of 100 selectors is allowed across `IncludeFilters` and
/// `ExcludeFilters` combined.
pub const OTelEnrichmentMetricSelector = struct {
    /// The names of the metrics to select within the namespace. Metric names are
    /// matched
    /// exactly and are case-sensitive. If this parameter is omitted, every metric
    /// in the
    /// namespace is selected.
    ///
    /// A maximum of 100 metric names is allowed for each selector.
    metric_names: ?[]const []const u8 = null,

    /// The namespace of the metrics to select. Namespaces are matched exactly and
    /// are
    /// case-sensitive.
    namespace: []const u8,

    pub const json_field_names = .{
        .metric_names = "MetricNames",
        .namespace = "Namespace",
    };
};
