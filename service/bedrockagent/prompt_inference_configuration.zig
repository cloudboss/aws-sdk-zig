const PromptModelInferenceConfiguration = @import("prompt_model_inference_configuration.zig").PromptModelInferenceConfiguration;

/// Contains inference configurations for the prompt.
pub const PromptInferenceConfiguration = union(enum) {
    /// Contains inference configurations for a text prompt.
    text: ?PromptModelInferenceConfiguration,

    pub const json_field_names = .{
        .text = "text",
    };
};
