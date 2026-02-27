const Timezone = @import("timezone.zig").Timezone;

/// The details of the schedule of the data source runs.
pub const ScheduleConfiguration = struct {
    /// The schedule of the data source runs.
    schedule: ?[]const u8,

    /// The timezone of the data source run.
    timezone: ?Timezone,

    pub const json_field_names = .{
        .schedule = "schedule",
        .timezone = "timezone",
    };
};
