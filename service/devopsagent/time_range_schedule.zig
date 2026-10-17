const Recurrence = @import("recurrence.zig").Recurrence;

/// Recurring time-of-day window in UTC. The service derives an EventBridge
/// expression anchored at startAfter and a flexible-window width from the
/// interval to startBefore. A startBefore earlier than startAfter wraps past
/// midnight.
pub const TimeRangeSchedule = struct {
    /// How the window recurs
    recurrence: Recurrence,

    /// Earliest time of day the trigger may fire
    start_after: []const u8,

    /// Latest time of day the trigger may fire
    start_before: []const u8,

    pub const json_field_names = .{
        .recurrence = "recurrence",
        .start_after = "startAfter",
        .start_before = "startBefore",
    };
};
