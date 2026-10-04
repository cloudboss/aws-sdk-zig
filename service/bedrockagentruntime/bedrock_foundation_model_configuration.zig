const BedrockFoundationModelModelConfiguration = @import("bedrock_foundation_model_model_configuration.zig").BedrockFoundationModelModelConfiguration;

/// Configuration for a Bedrock foundation model.
pub const BedrockFoundationModelConfiguration = struct {
    /// The model configuration containing the model ARN.
    model_configuration: BedrockFoundationModelModelConfiguration,

    pub const json_field_names = .{
        .model_configuration = "modelConfiguration",
    };
};
