pub const TrainingJobEarlyStoppingType = enum {
    off,
    auto,

    pub const json_field_names = .{
        .off = "OFF",
        .auto = "AUTO",
    };
};
