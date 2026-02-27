const PerformanceInsightsMetricDimensionGroup = @import("performance_insights_metric_dimension_group.zig").PerformanceInsightsMetricDimensionGroup;

/// A single Performance Insights metric query to process. You must provide the
/// metric to the query. If other parameters aren't specified, Performance
/// Insights returns all data points for the specified metric. Optionally, you
/// can request the data points to be aggregated by dimension group (`GroupBy`)
/// and return only those data points that match your criteria (`Filter`).
///
/// Constraints:
///
/// * Must be a valid Performance Insights query.
pub const PerformanceInsightsMetricQuery = struct {
    /// A specification for how to aggregate the data points from a query result.
    /// You must specify a valid dimension group. Performance Insights will return
    /// all of the dimensions within that group, unless you provide the names of
    /// specific dimensions within that group. You can also request that Performance
    /// Insights return a limited number of values for a dimension.
    group_by: ?PerformanceInsightsMetricDimensionGroup,

    /// The name of a Performance Insights metric to be measured.
    ///
    /// Valid Values:
    ///
    /// * `db.load.avg` - A scaled representation of the number of active sessions
    ///   for the database engine.
    /// * `db.sampledload.avg` - The raw number of active sessions for the database
    ///   engine.
    /// * The counter metrics listed in [Performance Insights operating system
    ///   counters](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_PerfInsights_Counters.html#USER_PerfInsights_Counters.OS) in the *Amazon Aurora User Guide*.
    ///
    /// If the number of active sessions is less than an internal Performance
    /// Insights threshold, `db.load.avg` and `db.sampledload.avg` are the same
    /// value. If the number of active sessions is greater than the internal
    /// threshold, Performance Insights samples the active sessions, with
    /// `db.load.avg` showing the scaled values, `db.sampledload.avg` showing the
    /// raw values, and `db.sampledload.avg` less than `db.load.avg`. For most use
    /// cases, you can query `db.load.avg` only.
    metric: ?[]const u8,
};
