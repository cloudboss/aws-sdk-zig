/// The metadata of the Amazon Bedrock custom model.
pub const BedrockCustomModelMetadata = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Bedrock custom model.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
