pub const MediaStreamType = enum {
    mixed_audio,
    individual_audio,

    pub const json_field_names = .{
        .mixed_audio = "MixedAudio",
        .individual_audio = "IndividualAudio",
    };
};
