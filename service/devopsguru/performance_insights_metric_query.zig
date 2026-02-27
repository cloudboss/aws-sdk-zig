const aws = @import("aws");

const PerformanceInsightsMetricDimensionGroup = @import("performance_insights_metric_dimension_group.zig").PerformanceInsightsMetricDimensionGroup;

/// A single query to be processed. Use these parameters to query the
/// Performance Insights
/// `GetResourceMetrics` API to retrieve the metrics for an anomaly. For more
/// information, see `
/// [GetResourceMetrics](https://docs.aws.amazon.com/performance-insights/latest/APIReference/API_GetResourceMetrics.html)
/// ` in the *Amazon RDS Performance Insights API
/// Reference*.
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
pub const PerformanceInsightsMetricQuery = struct {
    /// One or more filters to apply to a Performance Insights `GetResourceMetrics`
    /// API query.
    /// Restrictions:
    ///
    /// * Any number of filters by the same dimension, as specified in the
    /// `GroupBy` parameter.
    ///
    /// * A single filter for any other dimension in this dimension group.
    filter: ?[]const aws.map.StringMapEntry,

    /// The specification for how to aggregate the data points from a Performance
    /// Insights
    /// `GetResourceMetrics` API query. The Performance Insights query returns all
    /// of the
    /// dimensions within that group, unless you provide the names of specific
    /// dimensions within
    /// that group. You can also request that Performance Insights return a limited
    /// number of values for a
    /// dimension.
    group_by: ?PerformanceInsightsMetricDimensionGroup,

    /// The name of the meteric used used when querying an Performance Insights
    /// `GetResourceMetrics` API for anomaly metrics.
    ///
    /// Valid values for `Metric` are:
    ///
    /// * `db.load.avg` - a scaled representation of the number of active sessions
    ///   for the
    /// database engine.
    ///
    /// * `db.sampledload.avg` - the raw number of active sessions for the database
    /// engine.
    ///
    /// If the number of active sessions is less than an internal Performance
    /// Insights threshold,
    /// `db.load.avg` and `db.sampledload.avg` are the same value. If
    /// the number of active sessions is greater than the internal threshold,
    /// Performance Insights samples the active sessions, with
    /// `db.load.avg` showing the scaled values, `db.sampledload.avg`
    /// showing the raw values, and `db.sampledload.avg` less than
    /// `db.load.avg`. For most use cases, you can query `db.load.avg`
    /// only.
    metric: ?[]const u8,

    pub const json_field_names = .{
        .filter = "Filter",
        .group_by = "GroupBy",
        .metric = "Metric",
    };
};
