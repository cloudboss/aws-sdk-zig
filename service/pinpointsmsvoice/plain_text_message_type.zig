/// An object that defines a message that contains unformatted text.
pub const PlainTextMessageType = struct {
    /// The language to use when delivering the message. For a complete list of
    /// supported languages, see the Amazon Polly Developer Guide.
    language_code: ?[]const u8 = null,

    /// The plain (not SSML-formatted) text to deliver to the recipient.
    text: ?[]const u8 = null,

    /// The name of the voice that you want to use to deliver the message. For a
    /// complete list of supported voices, see the Amazon Polly Developer Guide.
    voice_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text = "Text",
        .voice_id = "VoiceId",
    };
};
