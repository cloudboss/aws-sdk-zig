const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const MetricName = @import("metric_name.zig").MetricName;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

/// Defines the parameters for querying Reserved Instance coverage data,
/// including grouping options, metrics, and sorting preferences.
pub const ReservationCoverageQuery = struct {
    filter: ?Expression = null,

    /// The time granularity of the retrieved data: `HOURLY`, `DAILY`, or `MONTHLY`.
    granularity: ?Granularity = null,

    /// Specifies how to group the Reserved Instance coverage data, such as by
    /// service, Region, or instance type.
    group_by: ?[]const GroupDefinition = null,

    /// The coverage metrics to include in the results.
    ///
    /// Valid values for ReservationCoverageQuery metrics are `Hour`, `Unit`, and
    /// `Cost`.
    metrics: ?[]const MetricName = null,

    time_range: DateTimeRange,

    pub const json_field_names = .{
        .filter = "filter",
        .granularity = "granularity",
        .group_by = "groupBy",
        .metrics = "metrics",
        .time_range = "timeRange",
    };
};
