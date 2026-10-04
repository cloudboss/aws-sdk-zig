/// Configuration for a Google Gemini model provider. Requires an API key stored
/// in AgentCore Identity.
pub const HarnessGeminiModelConfig = struct {
    /// Provider-specific parameters passed through to the Gemini model provider
    /// unchanged.
    additional_params: ?[]const u8 = null,

    /// The ARN of your Gemini API key on AgentCore Identity.
    api_key_arn: []const u8,

    /// The maximum number of tokens to allow in the generated response per model
    /// call.
    max_tokens: ?i32 = null,

    /// The Gemini model ID.
    model_id: []const u8,

    /// The temperature to set when calling the model.
    temperature: ?f32 = null,

    /// The topK set when calling the model.
    top_k: ?i32 = null,

    /// The topP set when calling the model.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .additional_params = "additionalParams",
        .api_key_arn = "apiKeyArn",
        .max_tokens = "maxTokens",
        .model_id = "modelId",
        .temperature = "temperature",
        .top_k = "topK",
        .top_p = "topP",
    };
};
