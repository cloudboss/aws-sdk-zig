const aws = @import("aws");

const DependencyConfig = @import("dependency_config.zig").DependencyConfig;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const ServiceLevelIndicatorMetricType = @import("service_level_indicator_metric_type.zig").ServiceLevelIndicatorMetricType;

/// Use this structure to specify the information for the metric that a
/// period-based SLO will monitor.
pub const ServiceLevelIndicatorMetricConfig = struct {
    /// Identifies the dependency using the `DependencyKeyAttributes` and
    /// `DependencyOperationName`.
    dependency_config: ?DependencyConfig,

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
    key_attributes: ?[]const aws.map.StringMapEntry,

    /// If this SLO monitors a CloudWatch metric or the result of a CloudWatch
    /// metric math expression, use this structure to specify that metric or
    /// expression.
    metric_data_queries: ?[]const MetricDataQuery,

    /// The name of the CloudWatch metric to use for the SLO, when using a custom
    /// metric rather than Application Signals standard metrics.
    metric_name: ?[]const u8,

    /// If the SLO is to monitor either the `LATENCY` or `AVAILABILITY` metric that
    /// Application Signals collects, use this field to specify which of those
    /// metrics is used.
    metric_type: ?ServiceLevelIndicatorMetricType,

    /// If the SLO is to monitor a specific operation of the service, use this field
    /// to specify the name of that operation.
    operation_name: ?[]const u8,

    /// The number of seconds to use as the period for SLO evaluation. Your
    /// application's performance is compared to the SLI during each period. For
    /// each period, the application is determined to have either achieved or not
    /// achieved the necessary performance.
    period_seconds: ?i32,

    /// The statistic to use for comparison to the threshold. It can be any
    /// CloudWatch statistic or extended statistic. For more information about
    /// statistics, see [CloudWatch statistics
    /// definitions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html).
    statistic: ?[]const u8,

    pub const json_field_names = .{
        .dependency_config = "DependencyConfig",
        .key_attributes = "KeyAttributes",
        .metric_data_queries = "MetricDataQueries",
        .metric_name = "MetricName",
        .metric_type = "MetricType",
        .operation_name = "OperationName",
        .period_seconds = "PeriodSeconds",
        .statistic = "Statistic",
    };
};
