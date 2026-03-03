/// Specifications about the inference parameters that were provided alongside
/// the prompt. These are specified in the
/// [PromptOverrideConfiguration](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_PromptOverrideConfiguration.html) object that was set when the agent was created or updated. For more information, see [Inference parameters for foundation models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
pub const InferenceConfiguration = struct {
    /// The maximum number of tokens allowed in the generated response.
    maximum_length: ?i32 = null,

    /// A list of stop sequences. A stop sequence is a sequence of characters that
    /// causes the model to stop generating the response.
    stop_sequences: ?[]const []const u8 = null,

    /// The likelihood of the model selecting higher-probability options while
    /// generating a response. A lower value makes the model more likely to choose
    /// higher-probability options, while a higher value makes the model more likely
    /// to choose lower-probability options.
    temperature: ?f32 = null,

    /// While generating a response, the model determines the probability of the
    /// following token at each point of generation. The value that you set for
    /// `topK` is the number of most-likely candidates from which the model chooses
    /// the next token in the sequence. For example, if you set `topK` to 50, the
    /// model selects the next token from among the top 50 most likely choices.
    top_k: ?i32 = null,

    /// While generating a response, the model determines the probability of the
    /// following token at each point of generation. The value that you set for `Top
    /// P` determines the number of most-likely candidates from which the model
    /// chooses the next token in the sequence. For example, if you set `topP` to
    /// 0.8, the model only selects the next token from the top 80% of the
    /// probability distribution of next tokens.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .maximum_length = "maximumLength",
        .stop_sequences = "stopSequences",
        .temperature = "temperature",
        .top_k = "topK",
        .top_p = "topP",
    };
};
