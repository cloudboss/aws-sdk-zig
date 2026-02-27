pub const SearchTextAdditionalFeature = enum {
    time_zone,
    phonemes,
    access,
    contact,

    pub const json_field_names = .{
        .time_zone = "TIME_ZONE",
        .phonemes = "PHONEMES",
        .access = "ACCESS",
        .contact = "CONTACT",
    };
};
