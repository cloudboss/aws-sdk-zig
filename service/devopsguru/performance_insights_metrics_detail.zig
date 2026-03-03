const PerformanceInsightsMetricQuery = @import("performance_insights_metric_query.zig").PerformanceInsightsMetricQuery;
const PerformanceInsightsReferenceData = @import("performance_insights_reference_data.zig").PerformanceInsightsReferenceData;
const PerformanceInsightsStat = @import("performance_insights_stat.zig").PerformanceInsightsStat;

/// Details about Performance Insights metrics.
///
/// Amazon RDS Performance Insights enables you to monitor and explore different
/// dimensions of database load based on data captured from a running DB
/// instance.
/// DB load is measured as average active sessions. Performance Insights
/// provides the
/// data to API consumers as a two-dimensional time-series dataset. The time
/// dimension
/// provides DB load data for each time point in the queried time range. Each
/// time point
/// decomposes overall load in relation to the requested dimensions, measured at
/// that
/// time point. Examples include SQL, Wait event, User, and Host.
///
/// * To learn more about Performance Insights and Amazon Aurora DB instances,
///   go to the [ Amazon Aurora User
///   Guide](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_PerfInsights.html).
///
/// * To learn more about Performance Insights and Amazon RDS DB instances, go
///   to the [ Amazon RDS User
///   Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html).
pub const PerformanceInsightsMetricsDetail = struct {
    /// The name used for a specific Performance Insights metric.
    metric_display_name: ?[]const u8 = null,

    /// A single query to be processed for the metric. For more information, see `
    /// [PerformanceInsightsMetricQuery](https://docs.aws.amazon.com/devops-guru/latest/APIReference/API_PerformanceInsightsMetricQuery.html)
    /// `.
    metric_query: ?PerformanceInsightsMetricQuery = null,

    /// For more information, see `
    /// [PerformanceInsightsReferenceData](https://docs.aws.amazon.com/devops-guru/latest/APIReference/API_PerformanceInsightsReferenceData.html)
    /// `.
    reference_data: ?[]const PerformanceInsightsReferenceData = null,

    /// The metric statistics during the anomalous period detected by DevOps Guru;
    stats_at_anomaly: ?[]const PerformanceInsightsStat = null,

    /// Typical metric statistics that are not considered anomalous. When DevOps
    /// Guru analyzes
    /// metrics, it compares them to `StatsAtBaseline` to help determine if they are
    /// anomalous.
    stats_at_baseline: ?[]const PerformanceInsightsStat = null,

    /// The unit of measure for a metric. For example, a session or a process.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_display_name = "MetricDisplayName",
        .metric_query = "MetricQuery",
        .reference_data = "ReferenceData",
        .stats_at_anomaly = "StatsAtAnomaly",
        .stats_at_baseline = "StatsAtBaseline",
        .unit = "Unit",
    };
};
