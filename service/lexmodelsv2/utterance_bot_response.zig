const UtteranceContentType = @import("utterance_content_type.zig").UtteranceContentType;
const ImageResponseCard = @import("image_response_card.zig").ImageResponseCard;

/// An object that contains a response to the utterance from the bot.
pub const UtteranceBotResponse = struct {
    /// The text of the response to the utterance from the bot.
    content: ?[]const u8,

    /// The type of the response. The following values are possible:
    ///
    /// * `PlainText` – A plain text string.
    ///
    /// * `CustomPayload` – A response string that you can customize to include data
    ///   or metadata for your application.
    ///
    /// * `SSML` – A string that includes Speech Synthesis Markup Language to
    ///   customize the audio response.
    ///
    /// * `ImageResponseCard` – An image with buttons that the customer can select.
    ///   See
    ///   [ImageResponseCard](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_runtime_ImageResponseCard.html) for more information.
    content_type: ?UtteranceContentType,

    image_response_card: ?ImageResponseCard,

    pub const json_field_names = .{
        .content = "content",
        .content_type = "contentType",
        .image_response_card = "imageResponseCard",
    };
};
