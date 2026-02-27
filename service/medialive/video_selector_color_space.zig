/// Video Selector Color Space
pub const VideoSelectorColorSpace = enum {
    follow,
    hdr10,
    hlg_2020,
    rec_601,
    rec_709,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .hdr10 = "HDR10",
        .hlg_2020 = "HLG_2020",
        .rec_601 = "REC_601",
        .rec_709 = "REC_709",
    };
};
