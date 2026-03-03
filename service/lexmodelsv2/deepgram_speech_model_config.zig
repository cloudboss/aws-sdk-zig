/// Configuration settings for integrating Deepgram speech-to-text models with
/// Amazon Lex.
pub const DeepgramSpeechModelConfig = struct {
    /// The Amazon Resource Name (ARN) of the Secrets Manager secret that contains
    /// the Deepgram API token.
    api_token_secret_arn: []const u8,

    /// The identifier of the Deepgram speech-to-text model to use for processing
    /// speech input.
    model_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_token_secret_arn = "apiTokenSecretArn",
        .model_id = "modelId",
    };
};
