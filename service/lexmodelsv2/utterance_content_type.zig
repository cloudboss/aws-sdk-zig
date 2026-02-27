pub const UtteranceContentType = enum {
    plain_text,
    custom_payload,
    ssml,
    image_response_card,

    pub const json_field_names = .{
        .plain_text = "PlainText",
        .custom_payload = "CustomPayload",
        .ssml = "SSML",
        .image_response_card = "ImageResponseCard",
    };
};
