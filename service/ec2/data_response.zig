const MetricType = @import("metric_type.zig").MetricType;
const MetricPoint = @import("metric_point.zig").MetricPoint;
const PeriodType = @import("period_type.zig").PeriodType;
const StatisticType = @import("statistic_type.zig").StatisticType;

/// The response to a `DataQuery`.
pub const DataResponse = struct {
    /// The Region or Availability Zone that's the destination for the data query.
    /// For example, `eu-west-1`.
    destination: ?[]const u8,

    /// The ID passed in the `DataQuery`.
    id: ?[]const u8,

    /// The metric used for the network performance request.
    metric: ?MetricType,

    /// A list of `MetricPoint` objects.
    metric_points: ?[]const MetricPoint,

    /// The period used for the network performance request.
    period: ?PeriodType,

    /// The Region or Availability Zone that's the source for the data query. For
    /// example, `us-east-1`.
    source: ?[]const u8,

    /// The statistic used for the network performance request.
    statistic: ?StatisticType,
};
