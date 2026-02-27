pub const EncodingName = enum {
    jxsv,
    raw,
    smpte_291,
    pcm,

    pub const json_field_names = .{
        .jxsv = "jxsv",
        .raw = "raw",
        .smpte_291 = "smpte291",
        .pcm = "pcm",
    };
};
