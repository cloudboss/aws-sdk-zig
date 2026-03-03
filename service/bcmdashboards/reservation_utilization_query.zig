const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const GroupDefinition = @import("group_definition.zig").GroupDefinition;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

/// Defines the parameters for querying Reserved Instance utilization data,
/// including grouping options and time granularity.
pub const ReservationUtilizationQuery = struct {
    filter: ?Expression = null,

    /// The time granularity of the retrieved data: `HOURLY`, `DAILY`, or `MONTHLY`.
    granularity: ?Granularity = null,

    /// Specifies how to group the Reserved Instance utilization data, such as by
    /// service, Region, or instance type.
    group_by: ?[]const GroupDefinition = null,

    time_range: DateTimeRange,

    pub const json_field_names = .{
        .filter = "filter",
        .granularity = "granularity",
        .group_by = "groupBy",
        .time_range = "timeRange",
    };
};
