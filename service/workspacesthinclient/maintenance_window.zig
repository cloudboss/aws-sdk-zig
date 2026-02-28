const ApplyTimeOf = @import("apply_time_of.zig").ApplyTimeOf;
const DayOfWeek = @import("day_of_week.zig").DayOfWeek;
const MaintenanceWindowType = @import("maintenance_window_type.zig").MaintenanceWindowType;

/// Describes the maintenance window for a thin client device.
pub const MaintenanceWindow = struct {
    /// The option to set the maintenance window during the device local time or
    /// Universal Coordinated Time (UTC).
    apply_time_of: ?ApplyTimeOf,

    /// The days of the week during which the maintenance window is open.
    days_of_the_week: ?[]const DayOfWeek,

    /// The hour for the maintenance window end (`00`-`23`).
    end_time_hour: ?i32,

    /// The minutes for the maintenance window end (`00`-`59`).
    end_time_minute: ?i32,

    /// The hour for the maintenance window start (`00`-`23`).
    start_time_hour: ?i32,

    /// The minutes past the hour for the maintenance window start (`00`-`59`).
    start_time_minute: ?i32,

    /// An option to select the default or custom maintenance window.
    @"type": MaintenanceWindowType,

    pub const json_field_names = .{
        .apply_time_of = "applyTimeOf",
        .days_of_the_week = "daysOfTheWeek",
        .end_time_hour = "endTimeHour",
        .end_time_minute = "endTimeMinute",
        .start_time_hour = "startTimeHour",
        .start_time_minute = "startTimeMinute",
        .@"type" = "type",
    };
};
