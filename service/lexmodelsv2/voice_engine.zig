pub const VoiceEngine = enum {
    standard,
    neural,
    long_form,
    generative,

    pub const json_field_names = .{
        .standard = "Standard",
        .neural = "Neural",
        .long_form = "LongForm",
        .generative = "Generative",
    };
};
