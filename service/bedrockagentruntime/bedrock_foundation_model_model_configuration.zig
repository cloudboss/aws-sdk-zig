/// Model configuration for a Bedrock foundation model.
pub const BedrockFoundationModelModelConfiguration = struct {
    /// The ARN of the Bedrock foundation model.
    model_arn: []const u8,

    pub const json_field_names = .{
        .model_arn = "modelArn",
    };
};
