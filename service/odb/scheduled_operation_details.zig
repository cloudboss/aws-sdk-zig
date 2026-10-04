const DayOfWeek = @import("day_of_week.zig").DayOfWeek;

/// The scheduled start and stop times for an Autonomous Database on a specific
/// day of the week.
pub const ScheduledOperationDetails = struct {
    /// The day of the week on which the scheduled operation occurs.
    day_of_week: DayOfWeek,

    /// The scheduled start time for the Autonomous Database, in UTC.
    scheduled_start_time: ?[]const u8 = null,

    /// The scheduled stop time for the Autonomous Database, in UTC.
    scheduled_stop_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .day_of_week = "dayOfWeek",
        .scheduled_start_time = "scheduledStartTime",
        .scheduled_stop_time = "scheduledStopTime",
    };
};
