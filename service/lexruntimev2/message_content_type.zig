pub const MessageContentType = enum {
    custom_payload,
    image_response_card,
    plain_text,
    ssml,

    pub const json_field_names = .{
        .custom_payload = "CUSTOM_PAYLOAD",
        .image_response_card = "IMAGE_RESPONSE_CARD",
        .plain_text = "PLAIN_TEXT",
        .ssml = "SSML",
    };
};
