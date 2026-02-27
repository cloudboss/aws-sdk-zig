/// The configuration parameters that control how the foundation model behaves
/// during evaluation, including response generation settings.
pub const InferenceConfiguration = struct {
    /// The maximum number of tokens to generate in the model response during
    /// evaluation.
    max_tokens: ?i32,

    /// The list of sequences that will cause the model to stop generating tokens
    /// when encountered.
    stop_sequences: ?[]const []const u8,

    /// The temperature value that controls randomness in the model's responses.
    /// Lower values produce more deterministic outputs.
    temperature: ?f32,

    /// The top-p sampling parameter that controls the diversity of the model's
    /// responses by limiting the cumulative probability of token choices.
    top_p: ?f32,

    pub const json_field_names = .{
        .max_tokens = "maxTokens",
        .stop_sequences = "stopSequences",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
