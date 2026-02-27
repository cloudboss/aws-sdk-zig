/// The details of the maintenance configuration for the application.
pub const ApplicationMaintenanceConfigurationDescription = struct {
    /// The end time for the maintenance window.
    application_maintenance_window_end_time: []const u8,

    /// The start time for the maintenance window.
    application_maintenance_window_start_time: []const u8,

    pub const json_field_names = .{
        .application_maintenance_window_end_time = "ApplicationMaintenanceWindowEndTime",
        .application_maintenance_window_start_time = "ApplicationMaintenanceWindowStartTime",
    };
};
