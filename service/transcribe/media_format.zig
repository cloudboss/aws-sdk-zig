pub const MediaFormat = enum {
    mp3,
    mp4,
    wav,
    flac,
    ogg,
    amr,
    webm,
    m4_a,

    pub const json_field_names = .{
        .mp3 = "MP3",
        .mp4 = "MP4",
        .wav = "WAV",
        .flac = "FLAC",
        .ogg = "OGG",
        .amr = "AMR",
        .webm = "WEBM",
        .m4_a = "M4A",
    };
};
