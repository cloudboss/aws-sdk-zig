const SchedulingConfigEndBehavior = @import("scheduling_config_end_behavior.zig").SchedulingConfigEndBehavior;
const ScheduleMaintenanceWindow = @import("schedule_maintenance_window.zig").ScheduleMaintenanceWindow;

/// Over-the-air (OTA) task scheduling config.
pub const OtaTaskSchedulingConfig = struct {
    /// Specifies the end behavior for all task executions after a task reaches the
    /// selected `endTime`. If `endTime` is not selected when creating the task,
    /// then `endBehavior` does not apply.
    end_behavior: ?SchedulingConfigEndBehavior,

    /// The time an over-the-air (OTA) task will stop.
    end_time: ?[]const u8,

    /// Maintenance window list for over-the-air (OTA) task scheduling config.
    maintenance_windows: ?[]const ScheduleMaintenanceWindow,

    /// The time an over-the-air (OTA) task will start.
    start_time: ?[]const u8,

    pub const json_field_names = .{
        .end_behavior = "EndBehavior",
        .end_time = "EndTime",
        .maintenance_windows = "MaintenanceWindows",
        .start_time = "StartTime",
    };
};
