/// Choose how the service meters the loudness of your audio.
pub const Eac3AtmosMeteringMode = enum {
    leq_a,
    itu_bs_1770_1,
    itu_bs_1770_2,
    itu_bs_1770_3,
    itu_bs_1770_4,

    pub const json_field_names = .{
        .leq_a = "LEQ_A",
        .itu_bs_1770_1 = "ITU_BS_1770_1",
        .itu_bs_1770_2 = "ITU_BS_1770_2",
        .itu_bs_1770_3 = "ITU_BS_1770_3",
        .itu_bs_1770_4 = "ITU_BS_1770_4",
    };
};
