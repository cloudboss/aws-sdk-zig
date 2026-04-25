const aws = @import("aws");

const DependencyConfig = @import("dependency_config.zig").DependencyConfig;
const MetricSource = @import("metric_source.zig").MetricSource;
const ServiceLevelIndicatorMetricType = @import("service_level_indicator_metric_type.zig").ServiceLevelIndicatorMetricType;
const MonitoredRequestCountMetricDataQueries = @import("monitored_request_count_metric_data_queries.zig").MonitoredRequestCountMetricDataQueries;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;

/// This structure contains the information about the metric that is used for a
/// request-based SLO.
pub const RequestBasedServiceLevelIndicatorMetric = struct {
    /// Identifies the dependency using the `DependencyKeyAttributes` and
    /// `DependencyOperationName`.
    dependency_config: ?DependencyConfig = null,

    /// This is a string-to-string map that contains information about the type of
    /// object that this SLO is related to. It can include the following fields.
    ///
    /// * `Type` designates the type of object that this SLO is related to.
    /// * `ResourceType` specifies the type of the resource. This field is used only
    ///   when the value of the `Type` field is `Resource` or `AWS::Resource`.
    /// * `Name` specifies the name of the object. This is used only if the value of
    ///   the `Type` field is `Service`, `RemoteService`, or `AWS::Service`.
    /// * `Identifier` identifies the resource objects of this resource. This is
    ///   used only if the value of the `Type` field is `Resource` or
    ///   `AWS::Resource`.
    /// * `Environment` specifies the location where this object is hosted, or what
    ///   it belongs to.
    key_attributes: ?[]const aws.map.StringMapEntry = null,

    /// Identifies the metric source for SLOs on resources other than Application
    /// Signals services.
    metric_source: ?MetricSource = null,

    /// If the SLO monitors either the `LATENCY` or `AVAILABILITY` metric that
    /// Application Signals collects, this field displays which of those metrics is
    /// used.
    metric_type: ?ServiceLevelIndicatorMetricType = null,

    /// This structure defines the metric that is used as the "good request" or "bad
    /// request" value for a request-based SLO. This value observed for the metric
    /// defined in `TotalRequestCountMetric` is divided by the number found for
    /// `MonitoredRequestCountMetric` to determine the percentage of successful
    /// requests that this SLO tracks.
    monitored_request_count_metric: MonitoredRequestCountMetricDataQueries,

    /// If the SLO monitors a specific operation of the service, this field displays
    /// that operation name.
    operation_name: ?[]const u8 = null,

    /// This structure defines the metric that is used as the "total requests"
    /// number for a request-based SLO. The number observed for this metric is
    /// divided by the number of "good requests" or "bad requests" that is observed
    /// for the metric defined in `MonitoredRequestCountMetric`.
    total_request_count_metric: []const MetricDataQuery,

    pub const json_field_names = .{
        .dependency_config = "DependencyConfig",
        .key_attributes = "KeyAttributes",
        .metric_source = "MetricSource",
        .metric_type = "MetricType",
        .monitored_request_count_metric = "MonitoredRequestCountMetric",
        .operation_name = "OperationName",
        .total_request_count_metric = "TotalRequestCountMetric",
    };
};
