const MaintenanceDay = @import("maintenance_day.zig").MaintenanceDay;

/// Update maintenance setting for a flow.
pub const UpdateMaintenance = struct {
    /// A day of a week when the maintenance will happen.
    maintenance_day: ?MaintenanceDay = null,

    /// A scheduled date in ISO UTC format when the maintenance will happen. Use
    /// YYYY-MM-DD format. Example: 2021-01-30.
    maintenance_scheduled_date: ?[]const u8 = null,

    /// UTC time when the maintenance will happen. Use 24-hour HH:MM format. Minutes
    /// must be 00. Example: 13:00. The default value is 02:00.
    maintenance_start_hour: ?[]const u8 = null,

    pub const json_field_names = .{
        .maintenance_day = "MaintenanceDay",
        .maintenance_scheduled_date = "MaintenanceScheduledDate",
        .maintenance_start_hour = "MaintenanceStartHour",
    };
};
