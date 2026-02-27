const DurationUnit = @import("duration_unit.zig").DurationUnit;

/// If the interval for this service level objective is a calendar interval,
/// this structure contains the interval specifications.
pub const CalendarInterval = struct {
    /// Specifies the duration of each calendar interval. For example, if `Duration`
    /// is `1` and `DurationUnit` is `MONTH`, each interval is one month, aligned
    /// with the calendar.
    duration: i32,

    /// Specifies the calendar interval unit.
    duration_unit: DurationUnit,

    /// The date and time when you want the first interval to start. Be sure to
    /// choose a time that configures the intervals the way that you want. For
    /// example, if you want weekly intervals starting on Mondays at 6 a.m., be sure
    /// to specify a start time that is a Monday at 6 a.m.
    ///
    /// When used in a raw HTTP Query API, it is formatted as be epoch time in
    /// seconds. For example: `1698778057`
    ///
    /// As soon as one calendar interval ends, another automatically begins.
    start_time: i64,

    pub const json_field_names = .{
        .duration = "Duration",
        .duration_unit = "DurationUnit",
        .start_time = "StartTime",
    };
};
