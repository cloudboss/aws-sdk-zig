const aws = @import("aws");

const CostDriver = @import("cost_driver.zig").CostDriver;
const Expression = @import("expression.zig").Expression;
const ComparisonMetricValue = @import("comparison_metric_value.zig").ComparisonMetricValue;

/// Represents a collection of cost drivers and their associated metrics for
/// cost
/// comparison analysis.
pub const CostComparisonDriver = struct {
    /// An array of cost drivers, each representing a cost difference between the
    /// baseline and
    /// comparison time periods. Each entry also includes a metric delta (for
    /// example, usage
    /// change) that contributed to the cost variance, along with the identifier and
    /// type of
    /// change.
    cost_drivers: ?[]const CostDriver,

    cost_selector: ?Expression,

    /// A mapping of metric names to their comparison values.
    metrics: ?[]const aws.map.MapEntry(ComparisonMetricValue),

    pub const json_field_names = .{
        .cost_drivers = "CostDrivers",
        .cost_selector = "CostSelector",
        .metrics = "Metrics",
    };
};
