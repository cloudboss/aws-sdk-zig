const aws = @import("aws");

const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const InferenceConfig = @import("inference_config.zig").InferenceConfig;
const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;
const PromptTemplate = @import("prompt_template.zig").PromptTemplate;

/// Contains the generation configuration of the external source wrapper object.
pub const ExternalSourcesGenerationConfiguration = struct {
    /// Additional model parameters and their corresponding values not included in
    /// the textInferenceConfig structure for an external source. Takes in custom
    /// model parameters specific to the language model being used.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry = null,

    /// The configuration details for the guardrail.
    guardrail_configuration: ?GuardrailConfiguration = null,

    /// Configuration settings for inference when using RetrieveAndGenerate to
    /// generate responses while using an external source.
    inference_config: ?InferenceConfig = null,

    /// The latency configuration for the model.
    performance_config: ?PerformanceConfiguration = null,

    /// Contain the textPromptTemplate string for the external source wrapper
    /// object.
    prompt_template: ?PromptTemplate = null,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .guardrail_configuration = "guardrailConfiguration",
        .inference_config = "inferenceConfig",
        .performance_config = "performanceConfig",
        .prompt_template = "promptTemplate",
    };
};
