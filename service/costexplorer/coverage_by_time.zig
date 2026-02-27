const ReservationCoverageGroup = @import("reservation_coverage_group.zig").ReservationCoverageGroup;
const DateInterval = @import("date_interval.zig").DateInterval;
const Coverage = @import("coverage.zig").Coverage;

/// Reservation coverage for a specified period, in hours.
pub const CoverageByTime = struct {
    /// The groups of instances that the reservation covered.
    groups: ?[]const ReservationCoverageGroup,

    /// The period that this coverage was used over.
    time_period: ?DateInterval,

    /// The total reservation coverage, in hours.
    total: ?Coverage,

    pub const json_field_names = .{
        .groups = "Groups",
        .time_period = "TimePeriod",
        .total = "Total",
    };
};
