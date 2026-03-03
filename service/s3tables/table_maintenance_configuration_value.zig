const TableMaintenanceSettings = @import("table_maintenance_settings.zig").TableMaintenanceSettings;
const MaintenanceStatus = @import("maintenance_status.zig").MaintenanceStatus;

/// The values that define a maintenance configuration for a table.
pub const TableMaintenanceConfigurationValue = struct {
    /// Contains details about the settings for the maintenance configuration.
    settings: ?TableMaintenanceSettings = null,

    /// The status of the maintenance configuration.
    status: ?MaintenanceStatus = null,

    pub const json_field_names = .{
        .settings = "settings",
        .status = "status",
    };
};
