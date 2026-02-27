const aws = @import("aws");

const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const KbInferenceConfig = @import("kb_inference_config.zig").KbInferenceConfig;
const PromptTemplate = @import("prompt_template.zig").PromptTemplate;

/// The response generation configuration of the external source wrapper object.
pub const ExternalSourcesGenerationConfiguration = struct {
    /// Additional model parameters and their corresponding values not included in
    /// the text inference configuration for an external source. Takes in custom
    /// model parameters specific to the language model being used.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry,

    /// Configuration details for the guardrail.
    guardrail_configuration: ?GuardrailConfiguration,

    /// Configuration details for inference when using `RetrieveAndGenerate` to
    /// generate responses while using an external source.
    kb_inference_config: ?KbInferenceConfig,

    /// Contains the template for the prompt for the external source wrapper object.
    prompt_template: ?PromptTemplate,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .guardrail_configuration = "guardrailConfiguration",
        .kb_inference_config = "kbInferenceConfig",
        .prompt_template = "promptTemplate",
    };
};
