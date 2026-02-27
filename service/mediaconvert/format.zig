pub const Format = enum {
    mp_4,
    quicktime,
    matroska,
    webm,
    mxf,
    wave,

    pub const json_field_names = .{
        .mp_4 = "mp4",
        .quicktime = "quicktime",
        .matroska = "matroska",
        .webm = "webm",
        .mxf = "mxf",
        .wave = "wave",
    };
};
