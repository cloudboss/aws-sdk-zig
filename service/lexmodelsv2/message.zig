const CustomPayload = @import("custom_payload.zig").CustomPayload;
const ImageResponseCard = @import("image_response_card.zig").ImageResponseCard;
const PlainTextMessage = @import("plain_text_message.zig").PlainTextMessage;
const SSMLMessage = @import("ssml_message.zig").SSMLMessage;

/// The object that provides message text and its type.
pub const Message = struct {
    /// A message in a custom format defined by the client
    /// application.
    custom_payload: ?CustomPayload,

    /// A message that defines a response card that the client application
    /// can show to the user.
    image_response_card: ?ImageResponseCard,

    /// A message in plain text format.
    plain_text_message: ?PlainTextMessage,

    /// A message in Speech Synthesis Markup Language (SSML).
    ssml_message: ?SSMLMessage,

    pub const json_field_names = .{
        .custom_payload = "customPayload",
        .image_response_card = "imageResponseCard",
        .plain_text_message = "plainTextMessage",
        .ssml_message = "ssmlMessage",
    };
};
