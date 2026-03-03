const TextInferenceConfig = @import("text_inference_config.zig").TextInferenceConfig;

/// The configuration for inference settings when generating responses using
/// RetrieveAndGenerate.
pub const InferenceConfig = struct {
    /// Configuration settings specific to text generation while generating
    /// responses using RetrieveAndGenerate.
    text_inference_config: ?TextInferenceConfig = null,

    pub const json_field_names = .{
        .text_inference_config = "textInferenceConfig",
    };
};
