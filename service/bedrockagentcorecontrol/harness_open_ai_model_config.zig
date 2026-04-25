/// Configuration for an OpenAI model provider. Requires an API key stored in
/// AgentCore Identity.
pub const HarnessOpenAiModelConfig = struct {
    /// The ARN of your OpenAI API key on AgentCore Identity.
    api_key_arn: []const u8,

    /// The maximum number of tokens to allow in the generated response per
    /// iteration.
    max_tokens: ?i32 = null,

    /// The OpenAI model ID.
    model_id: []const u8,

    /// The temperature to set when calling the model.
    temperature: ?f32 = null,

    /// The topP set when calling the model.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .api_key_arn = "apiKeyArn",
        .max_tokens = "maxTokens",
        .model_id = "modelId",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
