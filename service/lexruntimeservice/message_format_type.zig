pub const MessageFormatType = enum {
    plain_text,
    custom_payload,
    ssml,
    composite,

    pub const json_field_names = .{
        .plain_text = "PLAIN_TEXT",
        .custom_payload = "CUSTOM_PAYLOAD",
        .ssml = "SSML",
        .composite = "COMPOSITE",
    };
};
