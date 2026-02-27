const CalendarInterval = @import("calendar_interval.zig").CalendarInterval;
const RollingInterval = @import("rolling_interval.zig").RollingInterval;

/// The time period used to evaluate the SLO. It can be either a calendar
/// interval or rolling interval.
pub const Interval = union(enum) {
    /// If the interval is a calendar interval, this structure contains the interval
    /// specifications.
    calendar_interval: ?CalendarInterval,
    /// If the interval is a rolling interval, this structure contains the interval
    /// specifications.
    rolling_interval: ?RollingInterval,

    pub const json_field_names = .{
        .calendar_interval = "CalendarInterval",
        .rolling_interval = "RollingInterval",
    };
};
