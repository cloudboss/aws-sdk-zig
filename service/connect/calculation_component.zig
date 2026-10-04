const MetricFilter = @import("metric_filter.zig").MetricFilter;

/// Represents a component metric referenced in a custom metric calculation
/// formula.
pub const CalculationComponent = struct {
    /// The alias used to reference this component in the calculation expression.
    alias: []const u8,

    /// The filters applied to the calculation component.
    metric_filters: ?[]const MetricFilter = null,

    /// The ARN of an AWS-managed metric used in this calculation component.
    /// Mutually exclusive with `MetricName`.
    metric_id: ?[]const u8 = null,

    /// The name of an AWS-managed metric used in this calculation component (for
    /// example, `CONTACTS_HANDLED`). Mutually exclusive with `MetricId`.
    metric_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .metric_filters = "MetricFilters",
        .metric_id = "MetricId",
        .metric_name = "MetricName",
    };
};
