const Day = @import("day.zig").Day;

/// Configuration for preferred day and time maintenance settings.
pub const PreferredDayTimeMaintenanceConfiguration = struct {
    /// The preferred day for maintenance operations.
    day: Day,

    /// The preferred time for maintenance operations.
    time: []const u8,

    pub const json_field_names = .{
        .day = "Day",
        .time = "Time",
    };
};
