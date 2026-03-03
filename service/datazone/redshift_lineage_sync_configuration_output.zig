const LineageSyncSchedule = @import("lineage_sync_schedule.zig").LineageSyncSchedule;

/// The Amaon Redshift lineage sync configuration.
pub const RedshiftLineageSyncConfigurationOutput = struct {
    /// Specifies whether the Amaon Redshift lineage sync configuration is enabled.
    enabled: ?bool = null,

    /// The lineage job ID of the Amaon Redshift lineage sync configuration.
    lineage_job_id: ?[]const u8 = null,

    /// The schedule of teh Amaon Redshift lineage sync configuration.
    schedule: ?LineageSyncSchedule = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .lineage_job_id = "lineageJobId",
        .schedule = "schedule",
    };
};
