pub const FindingPublishingFrequency = enum {
    fifteen_minutes,
    one_hour,
    six_hours,

    pub const json_field_names = .{
        .fifteen_minutes = "FIFTEEN_MINUTES",
        .one_hour = "ONE_HOUR",
        .six_hours = "SIX_HOURS",
    };
};
