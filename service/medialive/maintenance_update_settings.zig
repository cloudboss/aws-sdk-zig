const MaintenanceDay = @import("maintenance_day.zig").MaintenanceDay;

/// Placeholder documentation for MaintenanceUpdateSettings
pub const MaintenanceUpdateSettings = struct {
    /// Choose one day of the week for maintenance. The chosen day is used for all
    /// future maintenance windows.
    maintenance_day: ?MaintenanceDay = null,

    /// Choose a specific date for maintenance to occur. The chosen date is used for
    /// the next maintenance window only.
    maintenance_scheduled_date: ?[]const u8 = null,

    /// Choose the hour that maintenance will start. The chosen time is used for all
    /// future maintenance windows.
    maintenance_start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .maintenance_day = "MaintenanceDay",
        .maintenance_scheduled_date = "MaintenanceScheduledDate",
        .maintenance_start_time = "MaintenanceStartTime",
    };
};
