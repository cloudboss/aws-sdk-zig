/// The metadata of the Amazon Bedrock custom model deployment.
pub const BedrockCustomModelDeploymentMetadata = struct {
    /// The Amazon Resource Name (ARN) for the Amazon Bedrock custom model
    /// deployment.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
