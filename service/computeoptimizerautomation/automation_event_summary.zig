const SummaryDimension = @import("summary_dimension.zig").SummaryDimension;
const TimePeriod = @import("time_period.zig").TimePeriod;
const SummaryTotals = @import("summary_totals.zig").SummaryTotals;

/// A summary of automation events grouped by specified dimensions.
pub const AutomationEventSummary = struct {
    /// The dimensions used to group this summary, such as event status.
    dimensions: ?[]const SummaryDimension,

    /// The key identifier for this summary grouping.
    key: ?[]const u8,

    /// The time period covered by this summary, with inclusive start time and
    /// exclusive end time.
    time_period: ?TimePeriod,

    /// The aggregated totals for this summary, including event count and estimated
    /// savings.
    total: ?SummaryTotals,

    pub const json_field_names = .{
        .dimensions = "dimensions",
        .key = "key",
        .time_period = "timePeriod",
        .total = "total",
    };
};
