const MetricStat = @import("metric_stat.zig").MetricStat;

/// Use this structure to define a metric or metric math expression that you
/// want to use as for a service level objective.
///
/// Each `MetricDataQuery` in the `MetricDataQueries` array specifies either a
/// metric to retrieve, or a metric math expression to be performed on retrieved
/// metrics. A single `MetricDataQueries` array can include as many as 20
/// `MetricDataQuery` structures in the array. The 20 structures can include as
/// many as 10 structures that contain a `MetricStat` parameter to retrieve a
/// metric, and as many as 10 structures that contain the `Expression` parameter
/// to perform a math expression. Of those `Expression` structures, exactly one
/// must have true as the value for `ReturnData`. The result of this expression
/// used for the SLO.
///
/// For more information about metric math expressions, see [CloudWatchUse
/// metric
/// math](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html).
///
/// Within each `MetricDataQuery` object, you must specify either `Expression`
/// or `MetricStat` but not both.
pub const MetricDataQuery = struct {
    /// The ID of the account where this metric is located. If you are performing
    /// this operation in a monitoring account, use this to specify which source
    /// account to retrieve this metric from.
    account_id: ?[]const u8,

    /// This field can contain a metric math expression to be performed on the other
    /// metrics that you are retrieving within this `MetricDataQueries` structure.
    ///
    /// A math expression can use the `Id` of the other metrics or queries to refer
    /// to those metrics, and can also use the `Id` of other expressions to use the
    /// result of those expressions. For more information about metric math
    /// expressions, see [Metric Math Syntax and
    /// Functions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax) in the *Amazon CloudWatch User Guide*.
    ///
    /// Within each `MetricDataQuery` object, you must specify either `Expression`
    /// or `MetricStat` but not both.
    expression: ?[]const u8,

    /// A short name used to tie this object to the results in the response. This
    /// `Id` must be unique within a `MetricDataQueries` array. If you are
    /// performing math expressions on this set of data, this name represents that
    /// data and can serve as a variable in the metric math expression. The valid
    /// characters are letters, numbers, and underscore. The first character must be
    /// a lowercase letter.
    id: []const u8,

    /// A human-readable label for this metric or expression. This is especially
    /// useful if this is an expression, so that you know what the value represents.
    /// If the metric or expression is shown in a CloudWatch dashboard widget, the
    /// label is shown. If `Label` is omitted, CloudWatch generates a default.
    ///
    /// You can put dynamic expressions into a label, so that it is more
    /// descriptive. For more information, see [Using Dynamic
    /// Labels](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/graph-dynamic-labels.html).
    label: ?[]const u8,

    /// A metric to be used directly for the SLO, or to be used in the math
    /// expression that will be used for the SLO.
    ///
    /// Within one `MetricDataQuery` object, you must specify either `Expression` or
    /// `MetricStat` but not both.
    metric_stat: ?MetricStat,

    /// The granularity, in seconds, of the returned data points for this metric.
    /// For metrics with regular resolution, a period can be as short as one minute
    /// (60 seconds) and must be a multiple of 60. For high-resolution metrics that
    /// are collected at intervals of less than one minute, the period can be 1, 5,
    /// 10, 30, 60, or any multiple of 60. High-resolution metrics are those metrics
    /// stored by a `PutMetricData` call that includes a `StorageResolution` of 1
    /// second.
    ///
    /// If the `StartTime` parameter specifies a time stamp that is greater than 3
    /// hours ago, you must specify the period as follows or no data points in that
    /// time range is returned:
    ///
    /// * Start time between 3 hours and 15 days ago - Use a multiple of 60 seconds
    ///   (1 minute).
    /// * Start time between 15 and 63 days ago - Use a multiple of 300 seconds (5
    ///   minutes).
    /// * Start time greater than 63 days ago - Use a multiple of 3600 seconds (1
    ///   hour).
    period: ?i32,

    /// Use this only if you are using a metric math expression for the SLO. Specify
    /// `true` for `ReturnData` for only the one expression result to use as the
    /// alarm. For all other metrics and expressions in the same
    /// `CreateServiceLevelObjective` operation, specify `ReturnData` as `false`.
    return_data: ?bool,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .expression = "Expression",
        .id = "Id",
        .label = "Label",
        .metric_stat = "MetricStat",
        .period = "Period",
        .return_data = "ReturnData",
    };
};
