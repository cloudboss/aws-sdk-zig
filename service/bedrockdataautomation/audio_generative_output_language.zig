/// Configuration for Audio output language
pub const AudioGenerativeOutputLanguage = enum {
    default,
    en,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .en = "EN",
    };
};
