const aws = @import("aws");

const Expression = @import("expression.zig").Expression;
const ComparisonMetricValue = @import("comparison_metric_value.zig").ComparisonMetricValue;

/// Represents a comparison of cost and usage metrics between two time periods.
pub const CostAndUsageComparison = struct {
    cost_and_usage_selector: ?Expression = null,

    /// A mapping of metric names to their comparison values.
    metrics: ?[]const aws.map.MapEntry(ComparisonMetricValue) = null,

    pub const json_field_names = .{
        .cost_and_usage_selector = "CostAndUsageSelector",
        .metrics = "Metrics",
    };
};
