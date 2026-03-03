const aws = @import("aws");

const DimensionGroup = @import("dimension_group.zig").DimensionGroup;

/// A single query to be processed. You must provide the metric to query and
/// append an aggregate function to the metric.
/// For example, to find the average for the metric `db.load`
/// you must use `db.load.avg`. Valid values for aggregate functions include
/// `.avg`, `.min`,
/// `.max`, and `.sum`.
/// If no other parameters are specified, Performance Insights returns all data
/// points for the specified metric. Optionally, you can
/// request that the data points be aggregated by dimension group (`GroupBy`),
/// and return only
/// those data points that match your criteria (`Filter`).
pub const MetricQuery = struct {
    /// One or more filters to apply in the request. Restrictions:
    ///
    /// * Any number of filters by the same dimension, as specified in the `GroupBy`
    ///   parameter.
    ///
    /// * A single filter for any other dimension in this dimension group.
    ///
    /// The `db.sql.db_id` filter isn't available for RDS for SQL Server DB
    /// instances.
    filter: ?[]const aws.map.StringMapEntry = null,

    /// A specification for how to aggregate the data points from a query result.
    /// You must
    /// specify a valid dimension group. Performance Insights will return all of the
    /// dimensions within that group,
    /// unless you provide the names of specific dimensions within that group. You
    /// can also request
    /// that Performance Insights return a limited number of values for a dimension.
    group_by: ?DimensionGroup = null,

    /// The name of a Performance Insights metric to be measured.
    ///
    /// Valid values for `Metric` are:
    ///
    /// * `db.load.avg` - A scaled representation of the number of active sessions
    ///   for the
    /// database engine.
    ///
    /// * `db.sampledload.avg` - The raw number of active sessions for the database
    ///   engine.
    ///
    /// * The counter metrics listed in [Performance Insights
    /// operating system
    /// counters](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_PerfInsights_Counters.html#USER_PerfInsights_Counters.OS) in the *Amazon Aurora User Guide*.
    ///
    /// * The counter metrics listed in [Performance Insights
    /// operating system
    /// counters](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights_Counters.html#USER_PerfInsights_Counters.OS) in the *Amazon RDS User Guide*.
    ///
    /// If the number of active sessions is less than an internal Performance
    /// Insights threshold, `db.load.avg` and `db.sampledload.avg` are the same
    /// value. If the number of active sessions is greater than the internal
    /// threshold, Performance Insights samples the active sessions, with
    /// `db.load.avg` showing the
    /// scaled values, `db.sampledload.avg` showing the raw values, and
    /// `db.sampledload.avg` less than
    /// `db.load.avg`. For most use cases, you can query `db.load.avg` only.
    metric: []const u8,

    pub const json_field_names = .{
        .filter = "Filter",
        .group_by = "GroupBy",
        .metric = "Metric",
    };
};
