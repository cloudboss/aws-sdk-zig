const MetricType = @import("metric_type.zig").MetricType;
const PeriodType = @import("period_type.zig").PeriodType;
const StatisticType = @import("statistic_type.zig").StatisticType;

/// Describes an Infrastructure Performance subscription.
pub const Subscription = struct {
    /// The Region or Availability Zone that's the target for the subscription. For
    /// example, `eu-west-1`.
    destination: ?[]const u8,

    /// The metric used for the subscription.
    metric: ?MetricType,

    /// The data aggregation time for the subscription.
    period: ?PeriodType,

    /// The Region or Availability Zone that's the source for the subscription. For
    /// example, `us-east-1`.
    source: ?[]const u8,

    /// The statistic used for the subscription.
    statistic: ?StatisticType,
};
