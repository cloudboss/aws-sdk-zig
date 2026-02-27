const BedrockModelSpecification = @import("bedrock_model_specification.zig").BedrockModelSpecification;

/// Contains specifications for the sample utterance generation feature.
pub const SampleUtteranceGenerationSpecification = struct {
    bedrock_model_specification: ?BedrockModelSpecification,

    /// Specifies whether to enable sample utterance generation or not.
    enabled: bool = false,

    pub const json_field_names = .{
        .bedrock_model_specification = "bedrockModelSpecification",
        .enabled = "enabled",
    };
};
