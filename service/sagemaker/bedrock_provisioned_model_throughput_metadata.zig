/// The metadata of the Amazon Bedrock provisioned model throughput.
pub const BedrockProvisionedModelThroughputMetadata = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Bedrock provisioned model
    /// throughput.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
