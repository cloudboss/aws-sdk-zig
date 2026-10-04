const HarnessBedrockApiFormat = @import("harness_bedrock_api_format.zig").HarnessBedrockApiFormat;

/// Configuration for an Amazon Bedrock model provider.
pub const HarnessBedrockModelConfig = struct {
    /// Provider-specific parameters passed through to the model provider unchanged.
    additional_params: ?[]const u8 = null,

    /// The API format to use when calling the Bedrock provider.
    api_format: ?HarnessBedrockApiFormat = null,

    /// The maximum number of tokens to allow in the generated response per
    /// iteration.
    max_tokens: ?i32 = null,

    /// The Bedrock model ID.
    model_id: []const u8,

    /// The temperature to set when calling the model.
    temperature: ?f32 = null,

    /// The topP set when calling the model.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .additional_params = "additionalParams",
        .api_format = "apiFormat",
        .max_tokens = "maxTokens",
        .model_id = "modelId",
        .temperature = "temperature",
        .top_p = "topP",
    };
};
