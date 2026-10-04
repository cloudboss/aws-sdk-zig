const Timezone = @import("timezone.zig").Timezone;

/// Contains the settings for configuring lineage sync on a Snowflake
/// connection, including the schedule, timezone, and enabled state.
pub const LineageSyncInput = struct {
    /// Specifies whether lineage sync is enabled.
    enabled: bool,

    /// The schedule of the lineage sync.
    schedule: ?[]const u8 = null,

    /// The timezone of the lineage sync schedule.
    timezone: ?Timezone = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .schedule = "schedule",
        .timezone = "timezone",
    };
};
