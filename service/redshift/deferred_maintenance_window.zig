/// Describes a deferred maintenance window
pub const DeferredMaintenanceWindow = struct {
    /// A timestamp for the end of the time period when we defer maintenance.
    defer_maintenance_end_time: ?i64,

    /// A unique identifier for the maintenance window.
    defer_maintenance_identifier: ?[]const u8,

    /// A timestamp for the beginning of the time period when we defer maintenance.
    defer_maintenance_start_time: ?i64,
};
