pub const SegmentTemplateFormat = enum {
    number_with_timeline,
    time_with_timeline,
    number_with_duration,

    pub const json_field_names = .{
        .number_with_timeline = "NUMBER_WITH_TIMELINE",
        .time_with_timeline = "TIME_WITH_TIMELINE",
        .number_with_duration = "NUMBER_WITH_DURATION",
    };
};
