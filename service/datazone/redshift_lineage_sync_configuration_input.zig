const LineageSyncSchedule = @import("lineage_sync_schedule.zig").LineageSyncSchedule;

/// The Amaon Redshift lineage sync configuration.
pub const RedshiftLineageSyncConfigurationInput = struct {
    /// Specifies whether the Amaon Redshift lineage sync configuration is enabled.
    enabled: ?bool,

    /// The schedule of the Amaon Redshift lineage sync configuration.
    schedule: ?LineageSyncSchedule,

    pub const json_field_names = .{
        .enabled = "enabled",
        .schedule = "schedule",
    };
};
