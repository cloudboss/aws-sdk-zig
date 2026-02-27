/// Audio Language Selection Policy
pub const AudioLanguageSelectionPolicy = enum {
    loose,
    strict,

    pub const json_field_names = .{
        .loose = "LOOSE",
        .strict = "STRICT",
    };
};
