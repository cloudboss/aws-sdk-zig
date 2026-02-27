pub const TestExecutionModality = enum {
    text,
    audio,

    pub const json_field_names = .{
        .text = "Text",
        .audio = "Audio",
    };
};
