/// Audio Normalization Algorithm
pub const AudioNormalizationAlgorithm = enum {
    itu_1770_1,
    itu_1770_2,

    pub const json_field_names = .{
        .itu_1770_1 = "ITU_1770_1",
        .itu_1770_2 = "ITU_1770_2",
    };
};
