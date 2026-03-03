const PromptGenAiResource = @import("prompt_gen_ai_resource.zig").PromptGenAiResource;
const PromptInferenceConfiguration = @import("prompt_inference_configuration.zig").PromptInferenceConfiguration;
const PromptMetadataEntry = @import("prompt_metadata_entry.zig").PromptMetadataEntry;
const PromptTemplateConfiguration = @import("prompt_template_configuration.zig").PromptTemplateConfiguration;
const PromptTemplateType = @import("prompt_template_type.zig").PromptTemplateType;

/// Contains details about a variant of the prompt.
pub const PromptVariant = struct {
    /// Contains model-specific inference configurations that aren't in the
    /// `inferenceConfiguration` field. To see model-specific inference parameters,
    /// see [Inference request parameters and response fields for foundation
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    additional_model_request_fields: ?[]const u8 = null,

    /// Specifies a generative AI resource with which to use the prompt.
    gen_ai_resource: ?PromptGenAiResource = null,

    /// Contains inference configurations for the prompt variant.
    inference_configuration: ?PromptInferenceConfiguration = null,

    /// An array of objects, each containing a key-value pair that defines a
    /// metadata tag and value to attach to a prompt variant.
    metadata: ?[]const PromptMetadataEntry = null,

    /// The unique identifier of the model or [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) with which to run inference on the prompt.
    model_id: ?[]const u8 = null,

    /// The name of the prompt variant.
    name: []const u8,

    /// Contains configurations for the prompt template.
    template_configuration: PromptTemplateConfiguration,

    /// The type of prompt template to use.
    template_type: PromptTemplateType,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .gen_ai_resource = "genAiResource",
        .inference_configuration = "inferenceConfiguration",
        .metadata = "metadata",
        .model_id = "modelId",
        .name = "name",
        .template_configuration = "templateConfiguration",
        .template_type = "templateType",
    };
};
