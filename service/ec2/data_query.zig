const MetricType = @import("metric_type.zig").MetricType;
const PeriodType = @import("period_type.zig").PeriodType;
const StatisticType = @import("statistic_type.zig").StatisticType;

/// A query used for retrieving network health data.
pub const DataQuery = struct {
    /// The Region or Availability Zone that's the target for the data query. For
    /// example, `eu-north-1`.
    destination: ?[]const u8,

    /// A user-defined ID associated with a data query that's returned in the
    /// `dataResponse` identifying the query. For example, if you set the Id to
    /// `MyQuery01`in the query, the `dataResponse` identifies the query as
    /// `MyQuery01`.
    id: ?[]const u8,

    /// The metric used for the network performance request.
    metric: ?MetricType,

    /// The aggregation period used for the data query.
    period: ?PeriodType,

    /// The Region or Availability Zone that's the source for the data query. For
    /// example, `us-east-1`.
    source: ?[]const u8,

    /// The metric data aggregation period, `p50`, between the specified `startDate`
    /// and `endDate`. For example, a metric of `five_minutes` is the median of all
    /// the data points gathered within those five minutes. `p50` is the only
    /// supported metric.
    statistic: ?StatisticType,
};
