const PromptInferenceConfiguration = @import("prompt_inference_configuration.zig").PromptInferenceConfiguration;
const PromptTemplateConfiguration = @import("prompt_template_configuration.zig").PromptTemplateConfiguration;
const PromptTemplateType = @import("prompt_template_type.zig").PromptTemplateType;

/// Contains configurations for a prompt defined inline in the node.
pub const PromptFlowNodeInlineConfiguration = struct {
    /// Additional fields to be included in the model request for the Prompt node.
    additional_model_request_fields: ?[]const u8,

    /// Contains inference configurations for the prompt.
    inference_configuration: ?PromptInferenceConfiguration,

    /// The unique identifier of the model or [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) to run inference with.
    model_id: []const u8 = "",

    /// Contains a prompt and variables in the prompt that can be replaced with
    /// values at runtime.
    template_configuration: PromptTemplateConfiguration,

    /// The type of prompt template.
    template_type: PromptTemplateType = "TEXT",

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .inference_configuration = "inferenceConfiguration",
        .model_id = "modelId",
        .template_configuration = "templateConfiguration",
        .template_type = "templateType",
    };
};
