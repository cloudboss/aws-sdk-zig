pub const AcceleratorName = enum {
    a100,
    inferentia,
    k520,
    k80,
    m60,
    radeon_pro_v520,
    t4,
    vu9_p,
    v100,
    a10_g,
    h100,
    t4_g,

    pub const json_field_names = .{
        .a100 = "A100",
        .inferentia = "INFERENTIA",
        .k520 = "K520",
        .k80 = "K80",
        .m60 = "M60",
        .radeon_pro_v520 = "RADEON_PRO_V520",
        .t4 = "T4",
        .vu9_p = "VU9P",
        .v100 = "V100",
        .a10_g = "A10G",
        .h100 = "H100",
        .t4_g = "T4G",
    };
};
