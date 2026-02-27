const BedrockModelSpecification = @import("bedrock_model_specification.zig").BedrockModelSpecification;

/// Contains specifications for the assisted slot resolution feature.
pub const SlotResolutionImprovementSpecification = struct {
    /// An object containing information about the Amazon Bedrock model used to
    /// assist slot resolution.
    bedrock_model_specification: ?BedrockModelSpecification,

    /// Specifies whether assisted slot resolution is turned on or off.
    enabled: bool = false,

    pub const json_field_names = .{
        .bedrock_model_specification = "bedrockModelSpecification",
        .enabled = "enabled",
    };
};
