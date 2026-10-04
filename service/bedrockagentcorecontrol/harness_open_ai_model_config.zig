const HarnessOpenAiApiFormat = @import("harness_open_ai_api_format.zig").HarnessOpenAiApiFormat;

/// Configuration for an OpenAI model provider. Requires an API key stored in
/// AgentCore Identity.
pub const HarnessOpenAiModelConfig = struct {
    /// Provider-specific parameters passed through to the model provider unchanged.
    additional_params: ?[]const u8 = null,

    /// Optional custom endpoint URL for an OpenAI-compatible endpoint.
    api_base: ?[]const u8 = null,

    /// The API format to use when calling the OpenAI provider.
    api_format: ?HarnessOpenAiApiFormat = null,

    /// The ARN of your OpenAI API key on AgentCore Identity.
    api_key_arn: []const u8,

    /// The maximum number of tokens to allow in the generated response per model
    /// call.
    max_tokens: ?i32 = null,

    /// The OpenAI model ID.
    model_id: []const u8,

    /// The temperature to set when calling the model.
    temperature: ?f32 = null,

    /// The topP set when calling the model.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .additional_params = "additionalParams",
        .api_base = "apiBase",
        .api_format = "apiFormat",
        .api_key_arn = "apiKeyArn",
        .max_tokens = "maxTokens",
        .model_id = "modelId",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
