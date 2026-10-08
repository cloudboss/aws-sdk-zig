const VoiceMessageBodyTextType = @import("voice_message_body_text_type.zig").VoiceMessageBodyTextType;

/// The updated delivery parameters for the voice channel. Absent members
/// preserve the current value, and the empty sentinel on a member clears it.
pub const UpdateVoiceParameters = struct {
    /// The updated freeform voice template body. An empty string clears the
    /// previously stored value.
    inline_template_body: ?[]const u8 = null,

    /// The updated BCP 47 language code. An empty string clears the previously
    /// stored value.
    language_code: ?[]const u8 = null,

    /// The updated Amazon Polly voice ID. An empty string clears the previously
    /// stored value.
    voice_id: ?[]const u8 = null,

    /// The updated format of the voice message body. Valid values are TEXT and
    /// SSML. Omit this member to preserve the current value.
    voice_message_body_text_type: ?VoiceMessageBodyTextType = null,

    pub const json_field_names = .{
        .inline_template_body = "inlineTemplateBody",
        .language_code = "languageCode",
        .voice_id = "voiceId",
        .voice_message_body_text_type = "voiceMessageBodyTextType",
    };
};
