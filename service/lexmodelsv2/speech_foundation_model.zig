/// Configuration for a foundation model used for speech synthesis and
/// recognition capabilities.
pub const SpeechFoundationModel = struct {
    /// The Amazon Resource Name (ARN) of the foundation model used for speech
    /// processing.
    model_arn: []const u8,

    /// The identifier of the voice to use for speech synthesis with the foundation
    /// model.
    voice_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_arn = "modelArn",
        .voice_id = "voiceId",
    };
};
