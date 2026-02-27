const aws = @import("aws");

const DependencyConfig = @import("dependency_config.zig").DependencyConfig;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const ServiceLevelIndicatorMetricType = @import("service_level_indicator_metric_type.zig").ServiceLevelIndicatorMetricType;

/// This structure contains the information about the metric that is used for a
/// period-based SLO.
pub const ServiceLevelIndicatorMetric = struct {
    /// Identifies the dependency using the `DependencyKeyAttributes` and
    /// `DependencyOperationName`.
    dependency_config: ?DependencyConfig,

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
    key_attributes: ?[]const aws.map.StringMapEntry,

    /// If this SLO monitors a CloudWatch metric or the result of a CloudWatch
    /// metric math expression, this structure includes the information about that
    /// metric or expression.
    metric_data_queries: []const MetricDataQuery,

    /// If the SLO monitors either the `LATENCY` or `AVAILABILITY` metric that
    /// Application Signals collects, this field displays which of those metrics is
    /// used.
    metric_type: ?ServiceLevelIndicatorMetricType,

    /// If the SLO monitors a specific operation of the service, this field displays
    /// that operation name.
    operation_name: ?[]const u8,

    pub const json_field_names = .{
        .dependency_config = "DependencyConfig",
        .key_attributes = "KeyAttributes",
        .metric_data_queries = "MetricDataQueries",
        .metric_type = "MetricType",
        .operation_name = "OperationName",
    };
};
