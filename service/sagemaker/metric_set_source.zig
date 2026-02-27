pub const MetricSetSource = enum {
    train,
    validation,
    @"test",

    pub const json_field_names = .{
        .train = "TRAIN",
        .validation = "VALIDATION",
        .@"test" = "TEST",
    };
};
