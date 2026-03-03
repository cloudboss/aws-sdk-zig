const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;

/// The scheduled maintenance for a runtime engine.
pub const PendingMaintenance = struct {
    /// The specific runtime engine that the maintenance schedule applies to.
    engine_version: ?[]const u8 = null,

    /// The maintenance schedule for the runtime engine version.
    schedule: ?MaintenanceSchedule = null,

    pub const json_field_names = .{
        .engine_version = "engineVersion",
        .schedule = "schedule",
    };
};
