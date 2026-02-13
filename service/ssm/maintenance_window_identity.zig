/// Information about the maintenance window.
pub const MaintenanceWindowIdentity = struct {
    /// The number of hours before the end of the maintenance window that Amazon Web
    /// Services Systems Manager stops scheduling
    /// new tasks for execution.
    cutoff: ?i32,

    /// A description of the maintenance window.
    description: ?[]const u8,

    /// The duration of the maintenance window in hours.
    duration: ?i32,

    /// Indicates whether the maintenance window is enabled.
    enabled: ?bool,

    /// The date and time, in ISO-8601 Extended format, for when the maintenance
    /// window is scheduled
    /// to become inactive.
    end_date: ?[]const u8,

    /// The name of the maintenance window.
    name: ?[]const u8,

    /// The next time the maintenance window will actually run, taking into account
    /// any specified
    /// times for the maintenance window to become active or inactive.
    next_execution_time: ?[]const u8,

    /// The schedule of the maintenance window in the form of a cron or rate
    /// expression.
    schedule: ?[]const u8,

    /// The number of days to wait to run a maintenance window after the scheduled
    /// cron expression
    /// date and time.
    schedule_offset: ?i32,

    /// The time zone that the scheduled maintenance window executions are based on,
    /// in Internet
    /// Assigned Numbers Authority (IANA) format.
    schedule_timezone: ?[]const u8,

    /// The date and time, in ISO-8601 Extended format, for when the maintenance
    /// window is scheduled
    /// to become active.
    start_date: ?[]const u8,

    /// The ID of the maintenance window.
    window_id: ?[]const u8,

    pub const json_field_names = .{
        .cutoff = "Cutoff",
        .description = "Description",
        .duration = "Duration",
        .enabled = "Enabled",
        .end_date = "EndDate",
        .name = "Name",
        .next_execution_time = "NextExecutionTime",
        .schedule = "Schedule",
        .schedule_offset = "ScheduleOffset",
        .schedule_timezone = "ScheduleTimezone",
        .start_date = "StartDate",
        .window_id = "WindowId",
    };
};
