const MaintenanceDay = @import("maintenance_day.zig").MaintenanceDay;

/// Placeholder documentation for MaintenanceCreateSettings
pub const MaintenanceCreateSettings = struct {
    /// Choose one day of the week for maintenance. The chosen day is used for all
    /// future maintenance windows.
    maintenance_day: ?MaintenanceDay,

    /// Choose the hour that maintenance will start. The chosen time is used for all
    /// future maintenance windows.
    maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .maintenance_day = "MaintenanceDay",
        .maintenance_start_time = "MaintenanceStartTime",
    };
};
