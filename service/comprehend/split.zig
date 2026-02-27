pub const Split = enum {
    train,
    @"test",

    pub const json_field_names = .{
        .train = "TRAIN",
        .@"test" = "TEST",
    };
};
