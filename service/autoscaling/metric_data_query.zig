const MetricStat = @import("metric_stat.zig").MetricStat;

/// The metric data to return. Also defines whether this call is returning data
/// for one
/// metric only, or whether it is performing a math expression on the values of
/// returned
/// metric statistics to create a new time series. A time series is a series of
/// data points,
/// each of which is associated with a timestamp.
///
/// For more information and examples, see [Advanced predictive scaling policy
/// configurations using custom
/// metrics](https://docs.aws.amazon.com/autoscaling/ec2/userguide/predictive-scaling-customized-metric-specification.html) in
/// the *Amazon EC2 Auto Scaling User Guide*.
pub const MetricDataQuery = struct {
    /// The math expression to perform on the returned data, if this object is
    /// performing a
    /// math expression. This expression can use the `Id` of the other metrics to
    /// refer to those metrics, and can also use the `Id` of other expressions to
    /// use
    /// the result of those expressions.
    ///
    /// Conditional: Within each `MetricDataQuery` object, you must specify either
    /// `Expression` or `MetricStat`, but not both.
    expression: ?[]const u8 = null,

    /// A short name that identifies the object's results in the response. This name
    /// must be
    /// unique among all `MetricDataQuery` objects specified for a single scaling
    /// policy. If you are performing math expressions on this set of data, this
    /// name represents
    /// that data and can serve as a variable in the mathematical expression. The
    /// valid
    /// characters are letters, numbers, and underscores. The first character must
    /// be a
    /// lowercase letter.
    id: []const u8,

    /// A human-readable label for this metric or expression. This is especially
    /// useful if
    /// this is a math expression, so that you know what the value represents.
    label: ?[]const u8 = null,

    /// Information about the metric data to return.
    ///
    /// Conditional: Within each `MetricDataQuery` object, you must specify either
    /// `Expression` or `MetricStat`, but not both.
    metric_stat: ?MetricStat = null,

    /// Indicates whether to return the timestamps and raw data values of this
    /// metric.
    ///
    /// If you use any math expressions, specify `true` for this value for only the
    /// final math expression that the metric specification is based on. You must
    /// specify
    /// `false` for `ReturnData` for all the other metrics and
    /// expressions used in the metric specification.
    ///
    /// If you are only retrieving metrics and not performing any math expressions,
    /// do not
    /// specify anything for `ReturnData`. This sets it to its default
    /// (`true`).
    return_data: ?bool = null,
};
