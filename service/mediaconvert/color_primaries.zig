/// The color space primaries of the video track, defining the red, green, and
/// blue color coordinates used for the video. This information helps ensure
/// accurate color reproduction during playback and transcoding.
pub const ColorPrimaries = enum {
    itu_709,
    unspecified,
    reserved,
    itu_470_m,
    itu_470_bg,
    smpte_170_m,
    smpte_240_m,
    generic_film,
    itu_2020,
    smpte_428_1,
    smpte_431_2,
    smpte_eg_432_1,
    ipt,
    smpte_2067_xyz,
    ebu_3213_e,
    last,

    pub const json_field_names = .{
        .itu_709 = "ITU_709",
        .unspecified = "UNSPECIFIED",
        .reserved = "RESERVED",
        .itu_470_m = "ITU_470M",
        .itu_470_bg = "ITU_470BG",
        .smpte_170_m = "SMPTE_170M",
        .smpte_240_m = "SMPTE_240M",
        .generic_film = "GENERIC_FILM",
        .itu_2020 = "ITU_2020",
        .smpte_428_1 = "SMPTE_428_1",
        .smpte_431_2 = "SMPTE_431_2",
        .smpte_eg_432_1 = "SMPTE_EG_432_1",
        .ipt = "IPT",
        .smpte_2067_xyz = "SMPTE_2067XYZ",
        .ebu_3213_e = "EBU_3213_E",
        .last = "LAST",
    };
};
