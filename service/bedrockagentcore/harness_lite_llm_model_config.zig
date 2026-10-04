/// Configuration for a LiteLLM model provider, enabling connection to
/// third-party model providers.
pub const HarnessLiteLlmModelConfig = struct {
    /// Provider-specific parameters passed through to the model provider unchanged.
    additional_params: ?[]const u8 = null,

    /// The base URL for the model provider's API endpoint.
    api_base: ?[]const u8 = null,

    /// The ARN of the API key in AgentCore Identity for authenticating with the
    /// model provider.
    api_key_arn: ?[]const u8 = null,

    /// The maximum number of tokens to allow in the generated response per
    /// iteration.
    max_tokens: ?i32 = null,

    /// The LiteLLM model identifier (e.g., "anthropic/claude-3-sonnet").
    model_id: []const u8,

    /// The temperature to set when calling the model.
    temperature: ?f32 = null,

    /// The topP set when calling the model.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .additional_params = "additionalParams",
        .api_base = "apiBase",
        .api_key_arn = "apiKeyArn",
        .max_tokens = "maxTokens",
        .model_id = "modelId",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
