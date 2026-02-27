pub const AutoMLChannelType = enum {
    training,
    validation,

    pub const json_field_names = .{
        .training = "TRAINING",
        .validation = "VALIDATION",
    };
};
