const HarnessBedrockModelConfig = @import("harness_bedrock_model_config.zig").HarnessBedrockModelConfig;
const HarnessGeminiModelConfig = @import("harness_gemini_model_config.zig").HarnessGeminiModelConfig;
const HarnessLiteLlmModelConfig = @import("harness_lite_llm_model_config.zig").HarnessLiteLlmModelConfig;
const HarnessOpenAiModelConfig = @import("harness_open_ai_model_config.zig").HarnessOpenAiModelConfig;

/// Specification of which model to use.
pub const HarnessModelConfiguration = union(enum) {
    /// Configuration for an Amazon Bedrock model.
    bedrock_model_config: ?HarnessBedrockModelConfig,
    /// Configuration for a Google Gemini model.
    gemini_model_config: ?HarnessGeminiModelConfig,
    /// The LiteLLM model configuration for connecting to third-party model
    /// providers.
    lite_llm_model_config: ?HarnessLiteLlmModelConfig,
    /// Configuration for an OpenAI model.
    open_ai_model_config: ?HarnessOpenAiModelConfig,

    pub const json_field_names = .{
        .bedrock_model_config = "bedrockModelConfig",
        .gemini_model_config = "geminiModelConfig",
        .lite_llm_model_config = "liteLlmModelConfig",
        .open_ai_model_config = "openAiModelConfig",
    };
};
