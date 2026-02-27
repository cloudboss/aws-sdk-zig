pub const TextType = enum {
    ssml,
    text,

    pub const json_field_names = .{
        .ssml = "SSML",
        .text = "TEXT",
    };
};
