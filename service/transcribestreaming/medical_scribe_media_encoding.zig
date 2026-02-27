pub const MedicalScribeMediaEncoding = enum {
    pcm,
    ogg_opus,
    flac,

    pub const json_field_names = .{
        .pcm = "PCM",
        .ogg_opus = "OGG_OPUS",
        .flac = "FLAC",
    };
};
