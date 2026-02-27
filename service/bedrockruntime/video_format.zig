pub const VideoFormat = enum {
    mkv,
    mov,
    mp4,
    webm,
    flv,
    mpeg,
    mpg,
    wmv,
    three_gp,

    pub const json_field_names = .{
        .mkv = "MKV",
        .mov = "MOV",
        .mp4 = "MP4",
        .webm = "WEBM",
        .flv = "FLV",
        .mpeg = "MPEG",
        .mpg = "MPG",
        .wmv = "WMV",
        .three_gp = "THREE_GP",
    };
};
