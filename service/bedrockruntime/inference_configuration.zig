/// Base inference parameters to pass to a model in a call to
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) or [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html). For more information, see [Inference parameters for foundation models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
///
/// If you need to pass additional parameters that the model supports, use the
/// `additionalModelRequestFields` request field in the call to `Converse` or
/// `ConverseStream`. For more information, see [Model
/// parameters](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
pub const InferenceConfiguration = struct {
    /// The maximum number of tokens to allow in the generated response. The default
    /// value is the maximum allowed value for the model that you are using. For
    /// more information, see [Inference parameters for foundation
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    max_tokens: ?i32,

    /// A list of stop sequences. A stop sequence is a sequence of characters that
    /// causes the model to stop generating the response.
    stop_sequences: ?[]const []const u8,

    /// The likelihood of the model selecting higher-probability options while
    /// generating a response. A lower value makes the model more likely to choose
    /// higher-probability options, while a higher value makes the model more likely
    /// to choose lower-probability options.
    ///
    /// The default value is the default value for the model that you are using. For
    /// more information, see [Inference parameters for foundation
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    temperature: ?f32,

    /// The percentage of most-likely candidates that the model considers for the
    /// next token. For example, if you choose a value of 0.8 for `topP`, the model
    /// selects from the top 80% of the probability distribution of tokens that
    /// could be next in the sequence.
    ///
    /// The default value is the default value for the model that you are using. For
    /// more information, see [Inference parameters for foundation
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    top_p: ?f32,

    pub const json_field_names = .{
        .max_tokens = "maxTokens",
        .stop_sequences = "stopSequences",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
