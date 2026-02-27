const aws = @import("aws");

const PromptInferenceConfiguration = @import("prompt_inference_configuration.zig").PromptInferenceConfiguration;
const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;
const KnowledgeBasePromptTemplate = @import("knowledge_base_prompt_template.zig").KnowledgeBasePromptTemplate;

/// Configures how the knowledge base orchestrates the retrieval and generation
/// process, allowing for customization of prompts, inference parameters, and
/// performance settings.
pub const KnowledgeBaseOrchestrationConfiguration = struct {
    /// The additional model-specific request parameters as key-value pairs to be
    /// included in the request to the foundation model.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry,

    /// Contains inference configurations for the prompt.
    inference_config: ?PromptInferenceConfiguration,

    /// The performance configuration options for the knowledge base retrieval and
    /// generation process.
    performance_config: ?PerformanceConfiguration,

    /// A custom prompt template for orchestrating the retrieval and generation
    /// process.
    prompt_template: ?KnowledgeBasePromptTemplate,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .inference_config = "inferenceConfig",
        .performance_config = "performanceConfig",
        .prompt_template = "promptTemplate",
    };
};
