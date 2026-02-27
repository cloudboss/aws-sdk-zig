/// Contains inference configurations related to model inference for a prompt.
/// For more information, see [Inference
/// parameters](https://docs.aws.amazon.com/bedrock/latest/userguide/inference-parameters.html).
pub const PromptModelInferenceConfiguration = struct {
    /// The maximum number of tokens to return in the response.
    max_tokens: ?i32,

    /// A list of strings that define sequences after which the model will stop
    /// generating.
    stop_sequences: ?[]const []const u8,

    /// Controls the randomness of the response. Choose a lower value for more
    /// predictable outputs and a higher value for more surprising outputs.
    temperature: ?f32,

    /// The percentage of most-likely candidates that the model considers for the
    /// next token.
    top_p: ?f32,

    pub const json_field_names = .{
        .max_tokens = "maxTokens",
        .stop_sequences = "stopSequences",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
