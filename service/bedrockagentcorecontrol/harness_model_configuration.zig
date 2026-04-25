const HarnessBedrockModelConfig = @import("harness_bedrock_model_config.zig").HarnessBedrockModelConfig;
const HarnessGeminiModelConfig = @import("harness_gemini_model_config.zig").HarnessGeminiModelConfig;
const HarnessOpenAiModelConfig = @import("harness_open_ai_model_config.zig").HarnessOpenAiModelConfig;

/// Specification of which model to use.
pub const HarnessModelConfiguration = union(enum) {
    /// Configuration for an Amazon Bedrock model.
    bedrock_model_config: ?HarnessBedrockModelConfig,
    /// Configuration for a Google Gemini model.
    gemini_model_config: ?HarnessGeminiModelConfig,
    /// Configuration for an OpenAI model.
    open_ai_model_config: ?HarnessOpenAiModelConfig,

    pub const json_field_names = .{
        .bedrock_model_config = "bedrockModelConfig",
        .gemini_model_config = "geminiModelConfig",
        .open_ai_model_config = "openAiModelConfig",
    };
};
