const BurnRateConfiguration = @import("burn_rate_configuration.zig").BurnRateConfiguration;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const Goal = @import("goal.zig").Goal;
const MetricSourceType = @import("metric_source_type.zig").MetricSourceType;
const RequestBasedServiceLevelIndicator = @import("request_based_service_level_indicator.zig").RequestBasedServiceLevelIndicator;
const ServiceLevelIndicator = @import("service_level_indicator.zig").ServiceLevelIndicator;

/// A structure containing information about one service level objective (SLO)
/// that has been created in Application Signals. Creating SLOs can help you
/// ensure your services are performing to the level that you expect. SLOs help
/// you set and track a specific target level for the reliability and
/// availability of your applications and services. Each SLO uses a service
/// level indicator (SLI), which is a key performance metric, to calculate how
/// much underperformance can be tolerated before the goal that you set for the
/// SLO is not achieved.
pub const ServiceLevelObjective = struct {
    /// The ARN of this SLO.
    arn: []const u8,

    /// Each object in this array defines the length of the look-back window used to
    /// calculate one burn rate metric for this SLO. The burn rate measures how fast
    /// the service is consuming the error budget, relative to the attainment goal
    /// of the SLO.
    burn_rate_configurations: ?[]const BurnRateConfiguration,

    /// The date and time that this SLO was created. When used in a raw HTTP Query
    /// API, it is formatted as `yyyy-MM-dd'T'HH:mm:ss`. For example,
    /// `2019-07-01T23:59:59`.
    created_time: i64,

    /// The description that you created for this SLO.
    description: ?[]const u8,

    /// Displays whether this is a period-based SLO or a request-based SLO.
    evaluation_type: ?EvaluationType,

    goal: Goal,

    /// The time that this SLO was most recently updated. When used in a raw HTTP
    /// Query API, it is formatted as `yyyy-MM-dd'T'HH:mm:ss`. For example,
    /// `2019-07-01T23:59:59`.
    last_updated_time: i64,

    /// Displays the SLI metric source type for this SLO. Supported types are:
    ///
    /// * Service operation
    /// * Service dependency
    /// * CloudWatch metric
    metric_source_type: ?MetricSourceType,

    /// The name of this SLO.
    name: []const u8,

    /// A structure containing information about the performance metric that this
    /// SLO monitors, if this is a request-based SLO.
    request_based_sli: ?RequestBasedServiceLevelIndicator,

    /// A structure containing information about the performance metric that this
    /// SLO monitors, if this is a period-based SLO.
    sli: ?ServiceLevelIndicator,

    pub const json_field_names = .{
        .arn = "Arn",
        .burn_rate_configurations = "BurnRateConfigurations",
        .created_time = "CreatedTime",
        .description = "Description",
        .evaluation_type = "EvaluationType",
        .goal = "Goal",
        .last_updated_time = "LastUpdatedTime",
        .metric_source_type = "MetricSourceType",
        .name = "Name",
        .request_based_sli = "RequestBasedSli",
        .sli = "Sli",
    };
};
