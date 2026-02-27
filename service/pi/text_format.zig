pub const TextFormat = enum {
    plain_text,
    markdown,

    pub const json_field_names = .{
        .plain_text = "PLAIN_TEXT",
        .markdown = "MARKDOWN",
    };
};
