pub const SpeechModelPreference = enum {
    standard,
    neural,
    deepgram,

    pub const json_field_names = .{
        .standard = "Standard",
        .neural = "Neural",
        .deepgram = "Deepgram",
    };
};
