/// The lineage sync schedule.
pub const LineageSyncSchedule = struct {
    /// The lineage sync schedule.
    schedule: ?[]const u8 = null,

    pub const json_field_names = .{
        .schedule = "schedule",
    };
};
