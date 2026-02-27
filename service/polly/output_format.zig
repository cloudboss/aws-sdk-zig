pub const OutputFormat = enum {
    json,
    mp3,
    ogg_opus,
    ogg_vorbis,
    pcm,

    pub const json_field_names = .{
        .json = "JSON",
        .mp3 = "MP3",
        .ogg_opus = "OGG_OPUS",
        .ogg_vorbis = "OGG_VORBIS",
        .pcm = "PCM",
    };
};
