const ScheduleConfigurationUnit = @import("schedule_configuration_unit.zig").ScheduleConfigurationUnit;

/// Configuration for scheduled segment membership event notifications.
pub const ScheduleConfiguration = struct {
    /// The interval between scheduled executions.
    interval: i32,

    /// The unit for the interval. The following are valid values:
    ///
    /// * **HOURLY**: The interval is measured in hours.
    unit: ?ScheduleConfigurationUnit = null,

    pub const json_field_names = .{
        .interval = "Interval",
        .unit = "Unit",
    };
};
