const HandOffTime = @import("hand_off_time.zig").HandOffTime;

/// Information about on-call rotations that recur monthly.
pub const MonthlySetting = struct {
    /// The day of the month when monthly recurring on-call rotations begin.
    day_of_month: i32,

    /// The time of day when a monthly recurring on-call shift rotation begins.
    hand_off_time: HandOffTime,

    pub const json_field_names = .{
        .day_of_month = "DayOfMonth",
        .hand_off_time = "HandOffTime",
    };
};
