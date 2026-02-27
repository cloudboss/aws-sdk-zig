pub const SuggestAdditionalFeature = enum {
    core,
    time_zone,
    phonemes,
    access,

    pub const json_field_names = .{
        .core = "CORE",
        .time_zone = "TIME_ZONE",
        .phonemes = "PHONEMES",
        .access = "ACCESS",
    };
};
