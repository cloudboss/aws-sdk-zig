const aws = @import("aws");

const InferenceConfig = @import("inference_config.zig").InferenceConfig;
const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;
const PromptTemplate = @import("prompt_template.zig").PromptTemplate;
const QueryTransformationConfiguration = @import("query_transformation_configuration.zig").QueryTransformationConfiguration;

/// Settings for how the model processes the prompt prior to retrieval and
/// generation.
pub const OrchestrationConfiguration = struct {
    /// Additional model parameters and corresponding values not included in the
    /// textInferenceConfig structure for a knowledge base. This allows users to
    /// provide custom model parameters specific to the language model being used.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry,

    /// Configuration settings for inference when using RetrieveAndGenerate to
    /// generate responses while using a knowledge base as a source.
    inference_config: ?InferenceConfig,

    /// The latency configuration for the model.
    performance_config: ?PerformanceConfiguration,

    /// Contains the template for the prompt that's sent to the model. Orchestration
    /// prompts must include the `$conversation_history$` and
    /// `$output_format_instructions$` variables. For more information, see [Use
    /// placeholder
    /// variables](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-placeholders.html) in the user guide.
    prompt_template: ?PromptTemplate,

    /// To split up the prompt and retrieve multiple sources, set the transformation
    /// type to `QUERY_DECOMPOSITION`.
    query_transformation_configuration: ?QueryTransformationConfiguration,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .inference_config = "inferenceConfig",
        .performance_config = "performanceConfig",
        .prompt_template = "promptTemplate",
        .query_transformation_configuration = "queryTransformationConfiguration",
    };
};
