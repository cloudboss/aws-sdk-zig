pub const SpeechMarkType = enum {
    sentence,
    ssml,
    viseme,
    word,

    pub const json_field_names = .{
        .sentence = "SENTENCE",
        .ssml = "SSML",
        .viseme = "VISEME",
        .word = "WORD",
    };
};
