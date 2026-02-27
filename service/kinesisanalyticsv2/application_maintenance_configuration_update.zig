/// Describes the updated maintenance configuration for the application.
pub const ApplicationMaintenanceConfigurationUpdate = struct {
    /// The updated start time for the maintenance window.
    application_maintenance_window_start_time_update: []const u8,

    pub const json_field_names = .{
        .application_maintenance_window_start_time_update = "ApplicationMaintenanceWindowStartTimeUpdate",
    };
};
