const MaintenanceDay = @import("maintenance_day.zig").MaintenanceDay;

/// The maintenance setting of a flow.
pub const Maintenance = struct {
    /// A day of a week when the maintenance will happen. Use
    /// Monday/Tuesday/Wednesday/Thursday/Friday/Saturday/Sunday.
    maintenance_day: ?MaintenanceDay,

    /// The Maintenance has to be performed before this deadline in ISO UTC format.
    /// Example: 2021-01-30T08:30:00Z.
    maintenance_deadline: ?[]const u8,

    /// A scheduled date in ISO UTC format when the maintenance will happen. Use
    /// YYYY-MM-DD format. Example: 2021-01-30.
    maintenance_scheduled_date: ?[]const u8,

    /// UTC time when the maintenance will happen. Use 24-hour HH:MM format. Minutes
    /// must be 00. Example: 13:00. The default value is 02:00.
    maintenance_start_hour: ?[]const u8,

    pub const json_field_names = .{
        .maintenance_day = "MaintenanceDay",
        .maintenance_deadline = "MaintenanceDeadline",
        .maintenance_scheduled_date = "MaintenanceScheduledDate",
        .maintenance_start_hour = "MaintenanceStartHour",
    };
};
