const TableBucketMaintenanceSettings = @import("table_bucket_maintenance_settings.zig").TableBucketMaintenanceSettings;
const MaintenanceStatus = @import("maintenance_status.zig").MaintenanceStatus;

/// Details about the values that define the maintenance configuration for a
/// table bucket.
pub const TableBucketMaintenanceConfigurationValue = struct {
    /// Contains details about the settings of the maintenance configuration.
    settings: ?TableBucketMaintenanceSettings,

    /// The status of the maintenance configuration.
    status: ?MaintenanceStatus,

    pub const json_field_names = .{
        .settings = "settings",
        .status = "status",
    };
};
