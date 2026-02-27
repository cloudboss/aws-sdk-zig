const MaintenanceDay = @import("maintenance_day.zig").MaintenanceDay;

/// Placeholder documentation for MaintenanceStatus
pub const MaintenanceStatus = struct {
    /// The currently selected maintenance day.
    maintenance_day: ?MaintenanceDay,

    /// Maintenance is required by the displayed date and time. Date and time is in
    /// ISO.
    maintenance_deadline: ?[]const u8,

    /// The currently scheduled maintenance date and time. Date and time is in ISO.
    maintenance_scheduled_date: ?[]const u8,

    /// The currently selected maintenance start time. Time is in UTC.
    maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .maintenance_day = "MaintenanceDay",
        .maintenance_deadline = "MaintenanceDeadline",
        .maintenance_scheduled_date = "MaintenanceScheduledDate",
        .maintenance_start_time = "MaintenanceStartTime",
    };
};
