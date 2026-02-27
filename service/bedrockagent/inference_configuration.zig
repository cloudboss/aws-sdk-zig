/// Contains inference parameters to use when the agent invokes a foundation
/// model in the part of the agent sequence defined by the `promptType`. For
/// more information, see [Inference parameters for foundation
/// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
pub const InferenceConfiguration = struct {
    /// The maximum number of tokens to allow in the generated response.
    maximum_length: ?i32,

    /// A list of stop sequences. A stop sequence is a sequence of characters that
    /// causes the model to stop generating the response.
    stop_sequences: ?[]const []const u8,

    /// The likelihood of the model selecting higher-probability options while
    /// generating a response. A lower value makes the model more likely to choose
    /// higher-probability options, while a higher value makes the model more likely
    /// to choose lower-probability options.
    temperature: ?f32,

    /// While generating a response, the model determines the probability of the
    /// following token at each point of generation. The value that you set for
    /// `topK` is the number of most-likely candidates from which the model chooses
    /// the next token in the sequence. For example, if you set `topK` to 50, the
    /// model selects the next token from among the top 50 most likely choices.
    top_k: ?i32,

    /// While generating a response, the model determines the probability of the
    /// following token at each point of generation. The value that you set for `Top
    /// P` determines the number of most-likely candidates from which the model
    /// chooses the next token in the sequence. For example, if you set `topP` to
    /// 0.8, the model only selects the next token from the top 80% of the
    /// probability distribution of next tokens.
    top_p: ?f32,

    pub const json_field_names = .{
        .maximum_length = "maximumLength",
        .stop_sequences = "stopSequences",
        .temperature = "temperature",
        .top_k = "topK",
        .top_p = "topP",
    };
};
