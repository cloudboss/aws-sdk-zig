const Time = @import("time.zig").Time;

/// A daily schedule.
pub const DailySchedule = struct {
    /// The schedule start time.
    start_time: Time,

    pub const json_field_names = .{
        .start_time = "startTime",
    };
};
