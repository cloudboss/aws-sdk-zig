/// Container for this output. Some containers require a container settings
/// object. If not specified, the default object will be created.
pub const ContainerType = enum {
    f4_v,
    gif,
    ismv,
    m2_ts,
    m3_u8,
    cmfc,
    mov,
    mp4,
    mpd,
    mxf,
    ogg,
    webm,
    raw,
    y4_m,

    pub const json_field_names = .{
        .f4_v = "F4V",
        .gif = "GIF",
        .ismv = "ISMV",
        .m2_ts = "M2TS",
        .m3_u8 = "M3U8",
        .cmfc = "CMFC",
        .mov = "MOV",
        .mp4 = "MP4",
        .mpd = "MPD",
        .mxf = "MXF",
        .ogg = "OGG",
        .webm = "WEBM",
        .raw = "RAW",
        .y4_m = "Y4M",
    };
};
