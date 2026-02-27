const aws = @import("aws");

const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const KbInferenceConfig = @import("kb_inference_config.zig").KbInferenceConfig;
const PromptTemplate = @import("prompt_template.zig").PromptTemplate;

/// The configuration details for response generation based on retrieved text
/// chunks.
pub const GenerationConfiguration = struct {
    /// Additional model parameters and corresponding values not included in the
    /// `textInferenceConfig` structure for a knowledge base. This allows you to
    /// provide custom model parameters specific to the language model being used.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry,

    /// Contains configuration details for the guardrail.
    guardrail_configuration: ?GuardrailConfiguration,

    /// Contains configuration details for inference for knowledge base retrieval
    /// and response generation.
    kb_inference_config: ?KbInferenceConfig,

    /// Contains the template for the prompt that's sent to the model for response
    /// generation.
    prompt_template: ?PromptTemplate,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .guardrail_configuration = "guardrailConfiguration",
        .kb_inference_config = "kbInferenceConfig",
        .prompt_template = "promptTemplate",
    };
};
