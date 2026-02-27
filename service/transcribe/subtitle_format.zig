pub const SubtitleFormat = enum {
    vtt,
    srt,

    pub const json_field_names = .{
        .vtt = "VTT",
        .srt = "SRT",
    };
};
