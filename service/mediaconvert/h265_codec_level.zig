/// H.265 Level.
pub const H265CodecLevel = enum {
    auto,
    level_1,
    level_2,
    level_2_1,
    level_3,
    level_3_1,
    level_4,
    level_4_1,
    level_5,
    level_5_1,
    level_5_2,
    level_6,
    level_6_1,
    level_6_2,

    pub const json_field_names = .{
        .auto = "AUTO",
        .level_1 = "LEVEL_1",
        .level_2 = "LEVEL_2",
        .level_2_1 = "LEVEL_2_1",
        .level_3 = "LEVEL_3",
        .level_3_1 = "LEVEL_3_1",
        .level_4 = "LEVEL_4",
        .level_4_1 = "LEVEL_4_1",
        .level_5 = "LEVEL_5",
        .level_5_1 = "LEVEL_5_1",
        .level_5_2 = "LEVEL_5_2",
        .level_6 = "LEVEL_6",
        .level_6_1 = "LEVEL_6_1",
        .level_6_2 = "LEVEL_6_2",
    };
};
