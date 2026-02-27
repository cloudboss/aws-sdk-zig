/// An optional configuration within the `SchedulingConfig` to setup a
/// recurring maintenance window with a predetermined start time and duration
/// for the
/// rollout of a job document to all devices in a target group for a job.
pub const MaintenanceWindow = struct {
    /// Displays the duration of the next maintenance window.
    duration_in_minutes: i32,

    /// Displays the start time of the next maintenance window.
    start_time: []const u8,

    pub const json_field_names = .{
        .duration_in_minutes = "durationInMinutes",
        .start_time = "startTime",
    };
};
