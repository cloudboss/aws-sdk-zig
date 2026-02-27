/// H265 Level
pub const H265Level = enum {
    h265_level_1,
    h265_level_2,
    h265_level_2_1,
    h265_level_3,
    h265_level_3_1,
    h265_level_4,
    h265_level_4_1,
    h265_level_5,
    h265_level_5_1,
    h265_level_5_2,
    h265_level_6,
    h265_level_6_1,
    h265_level_6_2,
    h265_level_auto,

    pub const json_field_names = .{
        .h265_level_1 = "H265_LEVEL_1",
        .h265_level_2 = "H265_LEVEL_2",
        .h265_level_2_1 = "H265_LEVEL_2_1",
        .h265_level_3 = "H265_LEVEL_3",
        .h265_level_3_1 = "H265_LEVEL_3_1",
        .h265_level_4 = "H265_LEVEL_4",
        .h265_level_4_1 = "H265_LEVEL_4_1",
        .h265_level_5 = "H265_LEVEL_5",
        .h265_level_5_1 = "H265_LEVEL_5_1",
        .h265_level_5_2 = "H265_LEVEL_5_2",
        .h265_level_6 = "H265_LEVEL_6",
        .h265_level_6_1 = "H265_LEVEL_6_1",
        .h265_level_6_2 = "H265_LEVEL_6_2",
        .h265_level_auto = "H265_LEVEL_AUTO",
    };
};
