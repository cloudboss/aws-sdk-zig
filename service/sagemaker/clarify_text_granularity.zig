pub const ClarifyTextGranularity = enum {
    token,
    sentence,
    paragraph,

    pub const json_field_names = .{
        .token = "TOKEN",
        .sentence = "SENTENCE",
        .paragraph = "PARAGRAPH",
    };
};
