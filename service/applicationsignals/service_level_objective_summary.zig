const aws = @import("aws");

const DependencyConfig = @import("dependency_config.zig").DependencyConfig;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const MetricSource = @import("metric_source.zig").MetricSource;
const MetricSourceType = @import("metric_source_type.zig").MetricSourceType;

/// A structure that contains information about one service level objective
/// (SLO) created in Application Signals.
pub const ServiceLevelObjectiveSummary = struct {
    /// The ARN of this service level objective.
    arn: []const u8,

    /// The date and time that this service level objective was created. It is
    /// expressed as the number of milliseconds since Jan 1, 1970 00:00:00 UTC.
    created_time: ?i64 = null,

    /// Identifies the dependency using the `DependencyKeyAttributes` and
    /// `DependencyOperationName`.
    dependency_config: ?DependencyConfig = null,

    /// Displays whether this is a period-based SLO or a request-based SLO.
    evaluation_type: ?EvaluationType = null,

    /// This is a string-to-string map. It can include the following fields.
    ///
    /// * `Type` designates the type of object this service level objective is for.
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

    /// Displays the SLI metric source type for this SLO. Supported types are:
    ///
    /// * Service operation
    /// * Service dependency
    /// * Service
    /// * CloudWatch metric
    /// * AppMonitor
    /// * Canary
    metric_source_type: ?MetricSourceType = null,

    /// The name of the service level objective.
    name: []const u8,

    /// If this service level objective is specific to a single operation, this
    /// field displays the name of that operation.
    operation_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .dependency_config = "DependencyConfig",
        .evaluation_type = "EvaluationType",
        .key_attributes = "KeyAttributes",
        .metric_source = "MetricSource",
        .metric_source_type = "MetricSourceType",
        .name = "Name",
        .operation_name = "OperationName",
    };
};
