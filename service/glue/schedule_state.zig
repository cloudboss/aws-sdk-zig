pub const ScheduleState = enum {
    scheduled,
    not_scheduled,
    transitioning,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .not_scheduled = "NOT_SCHEDULED",
        .transitioning = "TRANSITIONING",
    };
};
