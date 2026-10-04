const ReasoningConfiguration = @import("reasoning_configuration.zig").ReasoningConfiguration;

/// The configuration for using models served through the OpenResponses API in
/// evaluator assessments, including model selection and inference parameters.
pub const OpenResponsesEvaluatorModelConfig = struct {
    /// The maximum number of tokens to generate in the model response, including
    /// visible output and reasoning tokens.
    max_output_tokens: ?i32 = null,

    /// The identifier of the model to use for evaluation.
    model_id: []const u8,

    /// The reasoning configuration for reasoning models. Non-reasoning models
    /// ignore this configuration.
    reasoning: ?ReasoningConfiguration = null,

    /// The temperature value that controls randomness in the model's responses.
    /// Lower values produce more deterministic outputs.
    temperature: ?f32 = null,

    /// The top-p sampling parameter that controls the diversity of the model's
    /// responses by limiting the cumulative probability of token choices.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .max_output_tokens = "maxOutputTokens",
        .model_id = "modelId",
        .reasoning = "reasoning",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
