const aws = @import("aws");

/// Specifies the settings for a one-time voice message that's sent directly to
/// an endpoint through the voice channel.
pub const VoiceMessage = struct {
    /// The text of the script to use for the voice message.
    body: ?[]const u8,

    /// The code for the language to use when synthesizing the text of the message
    /// script. For a list of supported languages and the code for each one, see the
    /// [Amazon Polly Developer
    /// Guide](https://docs.aws.amazon.com/polly/latest/dg/what-is.html).
    language_code: ?[]const u8,

    /// The long code to send the voice message from. This value should be one of
    /// the dedicated long codes that's assigned to your AWS account. Although it
    /// isn't required, we recommend that you specify the long code in E.164 format,
    /// for example +12065550100, to ensure prompt and accurate delivery of the
    /// message.
    origination_number: ?[]const u8,

    /// The default message variables to use in the voice message. You can override
    /// the default variables with individual address variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8),

    /// The name of the voice to use when delivering the message. For a list of
    /// supported voices, see the [Amazon Polly Developer
    /// Guide](https://docs.aws.amazon.com/polly/latest/dg/what-is.html).
    voice_id: ?[]const u8,

    pub const json_field_names = .{
        .body = "Body",
        .language_code = "LanguageCode",
        .origination_number = "OriginationNumber",
        .substitutions = "Substitutions",
        .voice_id = "VoiceId",
    };
};
