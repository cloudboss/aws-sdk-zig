const aws = @import("aws");

const Group = @import("group.zig").Group;
const DateInterval = @import("date_interval.zig").DateInterval;
const MetricValue = @import("metric_value.zig").MetricValue;

/// The result that's associated with a time period.
pub const ResultByTime = struct {
    /// Determines whether the result is estimated.
    estimated: bool = false,

    /// The groups that this time period includes.
    groups: ?[]const Group,

    /// The time period that the result covers.
    time_period: ?DateInterval,

    /// The total amount of cost or usage accrued during the time period.
    total: ?[]const aws.map.MapEntry(MetricValue),

    pub const json_field_names = .{
        .estimated = "Estimated",
        .groups = "Groups",
        .time_period = "TimePeriod",
        .total = "Total",
    };
};
