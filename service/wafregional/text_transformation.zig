pub const TextTransformation = enum {
    none,
    compress_white_space,
    html_entity_decode,
    lowercase,
    cmd_line,
    url_decode,

    pub const json_field_names = .{
        .none = "NONE",
        .compress_white_space = "COMPRESS_WHITE_SPACE",
        .html_entity_decode = "HTML_ENTITY_DECODE",
        .lowercase = "LOWERCASE",
        .cmd_line = "CMD_LINE",
        .url_decode = "URL_DECODE",
    };
};
