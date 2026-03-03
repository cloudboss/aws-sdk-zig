const ReservationUtilizationGroup = @import("reservation_utilization_group.zig").ReservationUtilizationGroup;
const DateInterval = @import("date_interval.zig").DateInterval;
const ReservationAggregates = @import("reservation_aggregates.zig").ReservationAggregates;

/// The amount of utilization, in hours.
pub const UtilizationByTime = struct {
    /// The groups that this utilization result uses.
    groups: ?[]const ReservationUtilizationGroup = null,

    /// The period of time that this utilization was used for.
    time_period: ?DateInterval = null,

    /// The total number of reservation hours that were used.
    total: ?ReservationAggregates = null,

    pub const json_field_names = .{
        .groups = "Groups",
        .time_period = "TimePeriod",
        .total = "Total",
    };
};
