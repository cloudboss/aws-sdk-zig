const DayOfWeek = @import("day_of_week.zig").DayOfWeek;
const HandOffTime = @import("hand_off_time.zig").HandOffTime;

/// Information about rotations that recur weekly.
pub const WeeklySetting = struct {
    /// The day of the week when weekly recurring on-call shift rotations begins.
    day_of_week: DayOfWeek,

    /// The time of day when a weekly recurring on-call shift rotation begins.
    hand_off_time: HandOffTime,

    pub const json_field_names = .{
        .day_of_week = "DayOfWeek",
        .hand_off_time = "HandOffTime",
    };
};
