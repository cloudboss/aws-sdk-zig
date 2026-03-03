const MessageContentType = @import("message_content_type.zig").MessageContentType;
const ImageResponseCard = @import("image_response_card.zig").ImageResponseCard;

/// Container for text that is returned to the customer..
pub const Message = struct {
    /// The text of the message.
    content: ?[]const u8 = null,

    /// Indicates the type of response.
    content_type: MessageContentType,

    image_response_card: ?ImageResponseCard = null,

    pub const json_field_names = .{
        .content = "content",
        .content_type = "contentType",
        .image_response_card = "imageResponseCard",
    };
};
