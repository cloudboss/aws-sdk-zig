const BedrockModelSpecification = @import("bedrock_model_specification.zig").BedrockModelSpecification;

/// Contains specifications for the descriptive bot building feature.
pub const DescriptiveBotBuilderSpecification = struct {
    /// An object containing information about the Amazon Bedrock model used to
    /// interpret the prompt used in descriptive bot building.
    bedrock_model_specification: ?BedrockModelSpecification = null,

    /// Specifies whether the descriptive bot building feature is activated or not.
    enabled: bool = false,

    pub const json_field_names = .{
        .bedrock_model_specification = "bedrockModelSpecification",
        .enabled = "enabled",
    };
};
