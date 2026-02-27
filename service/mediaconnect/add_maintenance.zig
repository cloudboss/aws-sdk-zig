const MaintenanceDay = @import("maintenance_day.zig").MaintenanceDay;

/// Create a maintenance setting for a flow.
pub const AddMaintenance = struct {
    /// A day of a week when the maintenance will happen.
    maintenance_day: MaintenanceDay,

    /// UTC time when the maintenance will happen.
    ///
    /// Use 24-hour HH:MM format.
    ///
    /// Minutes must be 00.
    ///
    /// Example: 13:00.
    ///
    /// The default value is 02:00.
    maintenance_start_hour: []const u8,

    pub const json_field_names = .{
        .maintenance_day = "MaintenanceDay",
        .maintenance_start_hour = "MaintenanceStartHour",
    };
};
