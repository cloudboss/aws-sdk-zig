pub const TextPartType = enum {
    localized_text,
    plain_text,
    url,

    pub const json_field_names = .{
        .localized_text = "LOCALIZED_TEXT",
        .plain_text = "PLAIN_TEXT",
        .url = "URL",
    };
};
