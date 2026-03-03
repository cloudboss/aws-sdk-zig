const TopicScheduleType = @import("topic_schedule_type.zig").TopicScheduleType;

/// A structure that represents a topic refresh schedule.
pub const TopicRefreshSchedule = struct {
    /// A Boolean value that controls whether to schedule runs at the same schedule
    /// that is specified in
    /// SPICE dataset.
    based_on_spice_schedule: bool = false,

    /// A Boolean value that controls whether to schedule is enabled.
    is_enabled: bool,

    /// The time of day when the refresh should run, for
    /// example, Monday-Sunday.
    repeat_at: ?[]const u8 = null,

    /// The starting date and time for the refresh schedule.
    starting_at: ?i64 = null,

    /// The timezone that you want the refresh schedule to use.
    timezone: ?[]const u8 = null,

    /// The type of refresh schedule. Valid values for this structure are `HOURLY`,
    /// `DAILY`,
    /// `WEEKLY`,
    /// and `MONTHLY`.
    topic_schedule_type: ?TopicScheduleType = null,

    pub const json_field_names = .{
        .based_on_spice_schedule = "BasedOnSpiceSchedule",
        .is_enabled = "IsEnabled",
        .repeat_at = "RepeatAt",
        .starting_at = "StartingAt",
        .timezone = "Timezone",
        .topic_schedule_type = "TopicScheduleType",
    };
};
