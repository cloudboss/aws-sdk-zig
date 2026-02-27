const Expression = @import("expression.zig").Expression;
const Granularity = @import("granularity.zig").Granularity;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

/// Defines the parameters for querying Savings Plans utilization data,
/// including time granularity and sorting preferences.
pub const SavingsPlansUtilizationQuery = struct {
    filter: ?Expression,

    /// The time granularity of the retrieved data: HOURLY, DAILY, or MONTHLY.
    granularity: ?Granularity,

    time_range: DateTimeRange,

    pub const json_field_names = .{
        .filter = "filter",
        .granularity = "granularity",
        .time_range = "timeRange",
    };
};
