const VoiceMessageBodyTextType = @import("voice_message_body_text_type.zig").VoiceMessageBodyTextType;

/// The delivery parameters for the voice channel.
pub const VoiceParameters = struct {
    /// The freeform message template used to render the one-time passcode for the
    /// voice channel. The template must contain the code placeholder.
    inline_template_body: ?[]const u8 = null,

    /// The BCP 47 language code used to render the voice message.
    language_code: ?[]const u8 = null,

    /// The Amazon Polly voice ID used for the voice channel.
    voice_id: ?[]const u8 = null,

    /// The format of the voice message body. Valid values are TEXT and SSML.
    voice_message_body_text_type: ?VoiceMessageBodyTextType = null,

    pub const json_field_names = .{
        .inline_template_body = "inlineTemplateBody",
        .language_code = "languageCode",
        .voice_id = "voiceId",
        .voice_message_body_text_type = "voiceMessageBodyTextType",
    };
};
