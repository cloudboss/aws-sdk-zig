/// Property of colorCorrections. When you are using 3D LUT files to perform
/// color conversion on video, these are the supported color spaces.
pub const ColorSpace = enum {
    hdr10,
    hlg_2020,
    rec_601,
    rec_709,

    pub const json_field_names = .{
        .hdr10 = "HDR10",
        .hlg_2020 = "HLG_2020",
        .rec_601 = "REC_601",
        .rec_709 = "REC_709",
    };
};
