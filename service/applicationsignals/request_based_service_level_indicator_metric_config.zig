const aws = @import("aws");

const DependencyConfig = @import("dependency_config.zig").DependencyConfig;
const ServiceLevelIndicatorMetricType = @import("service_level_indicator_metric_type.zig").ServiceLevelIndicatorMetricType;
const MonitoredRequestCountMetricDataQueries = @import("monitored_request_count_metric_data_queries.zig").MonitoredRequestCountMetricDataQueries;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;

/// Use this structure to specify the information for the metric that a
/// period-based SLO will monitor.
pub const RequestBasedServiceLevelIndicatorMetricConfig = struct {
    /// Identifies the dependency using the `DependencyKeyAttributes` and
    /// `DependencyOperationName`.
    dependency_config: ?DependencyConfig = null,

    /// If this SLO is related to a metric collected by Application Signals, you
    /// must use this field to specify which service the SLO metric is related to.
    /// To do so, you must specify at least the `Type`, `Name`, and `Environment`
    /// attributes.
    ///
    /// This is a string-to-string map. It can include the following fields.
    ///
    /// * `Type` designates the type of object this is.
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

    /// If the SLO is to monitor either the `LATENCY` or `AVAILABILITY` metric that
    /// Application Signals collects, use this field to specify which of those
    /// metrics is used.
    metric_type: ?ServiceLevelIndicatorMetricType = null,

    /// Use this structure to define the metric that you want to use as the "good
    /// request" or "bad request" value for a request-based SLO. This value observed
    /// for the metric defined in `TotalRequestCountMetric` will be divided by the
    /// number found for `MonitoredRequestCountMetric` to determine the percentage
    /// of successful requests that this SLO tracks.
    monitored_request_count_metric: ?MonitoredRequestCountMetricDataQueries = null,

    /// If the SLO is to monitor a specific operation of the service, use this field
    /// to specify the name of that operation.
    operation_name: ?[]const u8 = null,

    /// Use this structure to define the metric that you want to use as the "total
    /// requests" number for a request-based SLO. This result will be divided by the
    /// "good request" or "bad request" value defined in
    /// `MonitoredRequestCountMetric`.
    total_request_count_metric: ?[]const MetricDataQuery = null,

    pub const json_field_names = .{
        .dependency_config = "DependencyConfig",
        .key_attributes = "KeyAttributes",
        .metric_type = "MetricType",
        .monitored_request_count_metric = "MonitoredRequestCountMetric",
        .operation_name = "OperationName",
        .total_request_count_metric = "TotalRequestCountMetric",
    };
};
