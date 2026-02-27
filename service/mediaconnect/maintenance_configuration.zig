const DefaultMaintenanceConfiguration = @import("default_maintenance_configuration.zig").DefaultMaintenanceConfiguration;
const PreferredDayTimeMaintenanceConfiguration = @import("preferred_day_time_maintenance_configuration.zig").PreferredDayTimeMaintenanceConfiguration;

/// The configuration settings for maintenance operations, including preferred
/// maintenance windows and schedules.
pub const MaintenanceConfiguration = union(enum) {
    /// Default maintenance configuration settings.
    default: ?DefaultMaintenanceConfiguration,
    /// Preferred day and time maintenance configuration settings.
    preferred_day_time: ?PreferredDayTimeMaintenanceConfiguration,

    pub const json_field_names = .{
        .default = "Default",
        .preferred_day_time = "PreferredDayTime",
    };
};
