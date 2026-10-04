const Timezone = @import("timezone.zig").Timezone;

/// Contains the current state of lineage sync for a Snowflake connection,
/// including the schedule, timezone, enabled state, and the ID of the
/// associated lineage job.
pub const LineageSyncOutput = struct {
    /// Specifies whether lineage sync is enabled.
    enabled: ?bool = null,

    /// The ID of the lineage sync job.
    lineage_job_id: ?[]const u8 = null,

    /// The schedule of the lineage sync.
    schedule: ?[]const u8 = null,

    /// The timezone of the lineage sync schedule.
    timezone: ?Timezone = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .lineage_job_id = "lineageJobId",
        .schedule = "schedule",
        .timezone = "timezone",
    };
};
