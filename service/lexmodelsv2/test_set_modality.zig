pub const TestSetModality = enum {
    text,
    audio,

    pub const json_field_names = .{
        .text = "Text",
        .audio = "Audio",
    };
};
