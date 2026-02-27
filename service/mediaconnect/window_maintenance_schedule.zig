/// Defines a specific time window for maintenance operations.
pub const WindowMaintenanceSchedule = struct {
    /// The end time of the maintenance window.
    end: i64,

    /// The date and time when the maintenance window is scheduled to occur.
    scheduled_time: i64,

    /// The start time of the maintenance window.
    start: i64,

    pub const json_field_names = .{
        .end = "End",
        .scheduled_time = "ScheduledTime",
        .start = "Start",
    };
};
