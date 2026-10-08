const BedrockFoundationModelConfiguration = @import("bedrock_foundation_model_configuration.zig").BedrockFoundationModelConfiguration;
const MantleFoundationModelConfiguration = @import("mantle_foundation_model_configuration.zig").MantleFoundationModelConfiguration;
const FoundationModelConfigurationType = @import("foundation_model_configuration_type.zig").FoundationModelConfigurationType;

/// Configuration for the foundation model.
pub const FoundationModelConfiguration = struct {
    /// The Bedrock foundation model configuration.
    bedrock_foundation_model_configuration: ?BedrockFoundationModelConfiguration = null,

    /// The Mantle foundation model configuration.
    mantle_foundation_model_configuration: ?MantleFoundationModelConfiguration = null,

    /// The type of foundation model configuration.
    type: FoundationModelConfigurationType,

    pub const json_field_names = .{
        .bedrock_foundation_model_configuration = "bedrockFoundationModelConfiguration",
        .mantle_foundation_model_configuration = "mantleFoundationModelConfiguration",
        .type = "type",
    };
};
