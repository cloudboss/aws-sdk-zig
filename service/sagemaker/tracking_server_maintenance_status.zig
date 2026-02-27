pub const TrackingServerMaintenanceStatus = enum {
    maintenance_in_progress,
    maintenance_complete,
    maintenance_failed,

    pub const json_field_names = .{
        .maintenance_in_progress = "MAINTENANCE_IN_PROGRESS",
        .maintenance_complete = "MAINTENANCE_COMPLETE",
        .maintenance_failed = "MAINTENANCE_FAILED",
    };
};
