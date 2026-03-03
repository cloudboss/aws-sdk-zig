/// Structure representing scheduling maintenance window.
pub const ScheduleMaintenanceWindow = struct {
    /// Displays the duration of the next maintenance window.
    duration_in_minutes: ?i32 = null,

    /// Displays the start time of the next maintenance window.
    start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .duration_in_minutes = "DurationInMinutes",
        .start_time = "StartTime",
    };
};
