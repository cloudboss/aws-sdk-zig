const aws = @import("aws");

const ComparisonMetricValue = @import("comparison_metric_value.zig").ComparisonMetricValue;

/// Represents factors that contribute to cost variations between the baseline
/// and
/// comparison time periods, including the type of driver, an identifier of the
/// driver, and
/// associated metrics.
pub const CostDriver = struct {
    /// A mapping of metric names to their comparison values, measuring the impact
    /// of this
    /// cost driver.
    metrics: ?[]const aws.map.MapEntry(ComparisonMetricValue),

    /// The specific identifier of the cost driver.
    name: ?[]const u8,

    /// The category or classification of the cost driver.
    ///
    /// Values include: BUNDLED_DISCOUNT, CREDIT, OUT_OF_CYCLE_CHARGE, REFUND,
    /// RECURRING_RESERVATION_FEE, RESERVATION_USAGE, RI_VOLUME_DISCOUNT,
    /// SAVINGS_PLAN_USAGE,
    /// SAVINGS_PLAN_RECURRING_FEE, SUPPORT_FEE, TAX, UPFRONT_RESERVATION_FEE,
    /// USAGE_CHANGE,
    /// COMMITMENT
    type: ?[]const u8,

    pub const json_field_names = .{
        .metrics = "Metrics",
        .name = "Name",
        .type = "Type",
    };
};
