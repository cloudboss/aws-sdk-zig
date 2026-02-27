const VoiceEngine = @import("voice_engine.zig").VoiceEngine;

/// Defines settings for using an Amazon Polly voice to communicate with a
/// user.
///
/// Valid values include:
///
/// * `standard`
///
/// * `neural`
///
/// * `long-form`
///
/// * `generative`
pub const VoiceSettings = struct {
    /// Indicates the type of Amazon Polly voice that Amazon Lex should use for
    /// voice interaction with the user. For more information, see the [
    /// `engine` parameter of the `SynthesizeSpeech`
    /// operation](https://docs.aws.amazon.com/polly/latest/dg/API_SynthesizeSpeech.html#polly-SynthesizeSpeech-request-Engine) in the *Amazon Polly developer guide*.
    ///
    /// If you do not specify a value, the default is `standard`.
    engine: ?VoiceEngine,

    /// The identifier of the Amazon Polly voice to use.
    voice_id: []const u8,

    pub const json_field_names = .{
        .engine = "engine",
        .voice_id = "voiceId",
    };
};
