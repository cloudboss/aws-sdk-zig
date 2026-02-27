const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const MetricName = @import("metric_name.zig").MetricName;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

/// Defines the parameters for querying Savings Plans coverage data, including
/// metrics, grouping options, and time granularity.
pub const SavingsPlansCoverageQuery = struct {
    filter: ?Expression,

    /// The time granularity of the retrieved data: `HOURLY`, `DAILY`, or `MONTHLY`.
    granularity: ?Granularity,

    /// Specifies how to group the Savings Plans coverage data, such as by service
    /// or instance family.
    group_by: ?[]const GroupDefinition,

    /// The coverage metrics to include in the results.
    ///
    /// Valid value for SavingsPlansCoverageQuery metrics is
    /// `SpendCoveredBySavingsPlans`.
    metrics: ?[]const MetricName,

    time_range: DateTimeRange,

    pub const json_field_names = .{
        .filter = "filter",
        .granularity = "granularity",
        .group_by = "groupBy",
        .metrics = "metrics",
        .time_range = "timeRange",
    };
};
