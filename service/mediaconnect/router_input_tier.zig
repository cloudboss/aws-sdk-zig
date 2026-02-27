pub const RouterInputTier = enum {
    input_100,
    input_50,
    input_20,

    pub const json_field_names = .{
        .input_100 = "INPUT_100",
        .input_50 = "INPUT_50",
        .input_20 = "INPUT_20",
    };
};
