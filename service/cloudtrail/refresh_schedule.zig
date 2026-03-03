const RefreshScheduleFrequency = @import("refresh_schedule_frequency.zig").RefreshScheduleFrequency;
const RefreshScheduleStatus = @import("refresh_schedule_status.zig").RefreshScheduleStatus;

/// The schedule for a dashboard refresh.
pub const RefreshSchedule = struct {
    /// The frequency at which you want the dashboard refreshed.
    frequency: ?RefreshScheduleFrequency = null,

    /// Specifies whether the refresh schedule is enabled. Set the value to
    /// `ENABLED` to enable the refresh schedule, or to `DISABLED` to turn off the
    /// refresh schedule.
    status: ?RefreshScheduleStatus = null,

    /// The time of day in UTC to run the schedule; for hourly only refer to
    /// minutes; default is 00:00.
    time_of_day: ?[]const u8 = null,

    pub const json_field_names = .{
        .frequency = "Frequency",
        .status = "Status",
        .time_of_day = "TimeOfDay",
    };
};
