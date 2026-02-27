pub const RecordingFrequency = enum {
    continuous,
    daily,

    pub const json_field_names = .{
        .continuous = "CONTINUOUS",
        .daily = "DAILY",
    };
};
