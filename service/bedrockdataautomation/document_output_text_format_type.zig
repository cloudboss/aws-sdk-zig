pub const DocumentOutputTextFormatType = enum {
    plain_text,
    markdown,
    html,
    csv,

    pub const json_field_names = .{
        .plain_text = "PLAIN_TEXT",
        .markdown = "MARKDOWN",
        .html = "HTML",
        .csv = "CSV",
    };
};
