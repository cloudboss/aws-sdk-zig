const TextInferenceConfig = @import("text_inference_config.zig").TextInferenceConfig;

/// Contains configuration details of the inference for knowledge base retrieval
/// and response generation.
pub const KbInferenceConfig = struct {
    /// Contains configuration details for text generation using a language model
    /// via the `RetrieveAndGenerate` function.
    text_inference_config: ?TextInferenceConfig = null,

    pub const json_field_names = .{
        .text_inference_config = "textInferenceConfig",
    };
};
