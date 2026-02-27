pub const RouterOutputTier = enum {
    output_100,
    output_50,
    output_20,

    pub const json_field_names = .{
        .output_100 = "OUTPUT_100",
        .output_50 = "OUTPUT_50",
        .output_20 = "OUTPUT_20",
    };
};
