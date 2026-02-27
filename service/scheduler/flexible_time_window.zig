const FlexibleTimeWindowMode = @import("flexible_time_window_mode.zig").FlexibleTimeWindowMode;

/// Allows you to configure a time window during which EventBridge Scheduler
/// invokes the schedule.
pub const FlexibleTimeWindow = struct {
    /// The maximum time window during which a schedule can be invoked.
    maximum_window_in_minutes: ?i32,

    /// Determines whether the schedule is invoked within a flexible time window.
    mode: FlexibleTimeWindowMode,

    pub const json_field_names = .{
        .maximum_window_in_minutes = "MaximumWindowInMinutes",
        .mode = "Mode",
    };
};
