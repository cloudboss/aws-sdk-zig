const WindowMaintenanceSchedule = @import("window_maintenance_schedule.zig").WindowMaintenanceSchedule;

/// The details of the maintenance schedule.
pub const MaintenanceSchedule = union(enum) {
    window: ?WindowMaintenanceSchedule,

    pub const json_field_names = .{
        .window = "Window",
    };
};
