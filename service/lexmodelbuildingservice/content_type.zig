pub const ContentType = enum {
    plain_text,
    ssml,
    custom_payload,

    pub const json_field_names = .{
        .plain_text = "PLAIN_TEXT",
        .ssml = "SSML",
        .custom_payload = "CUSTOM_PAYLOAD",
    };
};
