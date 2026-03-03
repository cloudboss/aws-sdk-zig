const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const MetricName = @import("metric_name.zig").MetricName;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

/// Defines the parameters for retrieving Amazon Web Services cost and usage
/// data. Includes specifications for metrics, time periods, granularity,
/// grouping dimensions, and filtering conditions.
pub const CostAndUsageQuery = struct {
    /// The filter expression to be applied to the cost and usage data.
    filter: ?Expression = null,

    /// The granularity of the retrieved data: `HOURLY`, `DAILY`, or `MONTHLY`.
    granularity: Granularity,

    /// Specifies how to group the retrieved data, such as by `SERVICE`, `ACCOUNT`,
    /// or `TAG`.
    group_by: ?[]const GroupDefinition = null,

    /// The specific cost and usage metrics to retrieve.
    ///
    /// Valid values for CostAndUsageQuery metrics are `AmortizedCost`,
    /// `BlendedCost`, `NetAmortizedCost`, `NetUnblendedCost`,
    /// `NormalizedUsageAmount`, `UnblendedCost`, and `UsageQuantity`.
    metrics: []const MetricName,

    /// The time period for which to retrieve data. Can be specified as absolute
    /// dates or relative time periods.
    time_range: DateTimeRange,

    pub const json_field_names = .{
        .filter = "filter",
        .granularity = "granularity",
        .group_by = "groupBy",
        .metrics = "metrics",
        .time_range = "timeRange",
    };
};
