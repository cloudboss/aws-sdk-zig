const aws = @import("aws");

/// An object describing a Performance Insights metric and one or more
/// dimensions for that metric.
pub const ResponseResourceMetricKey = struct {
    /// The valid dimensions for the metric.
    dimensions: ?[]const aws.map.StringMapEntry,

    /// The name of a Performance Insights metric to be measured.
    ///
    /// Valid values for `Metric` are:
    ///
    /// * `db.load.avg` - A scaled representation of the number of active sessions
    ///   for the database engine.
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
    /// Insights threshold, `db.load.avg` and
    /// `db.sampledload.avg` are the same value. If the number of active sessions is
    /// greater than the
    /// internal threshold, Performance Insights samples the active sessions, with
    /// `db.load.avg` showing the scaled values,
    /// `db.sampledload.avg` showing the raw values, and `db.sampledload.avg` less
    /// than `db.load.avg`. For most use cases, you can query `db.load.avg` only.
    metric: []const u8,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric = "Metric",
    };
};
