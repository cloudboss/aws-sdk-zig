const WaitTime = @import("wait_time.zig").WaitTime;

/// Specifies the settings for a wait activity in a journey. This type of
/// activity waits for a certain amount of time or until a specific date and
/// time before moving participants to the next activity in a journey.
pub const WaitActivity = struct {
    /// The unique identifier for the next activity to perform, after performing the
    /// wait activity.
    next_activity: ?[]const u8,

    /// The amount of time to wait or the date and time when the activity moves
    /// participants to the next activity in the journey.
    wait_time: ?WaitTime,

    pub const json_field_names = .{
        .next_activity = "NextActivity",
        .wait_time = "WaitTime",
    };
};
