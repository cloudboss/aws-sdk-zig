/// The metadata of the Amazon Bedrock model import.
pub const BedrockModelImportMetadata = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Bedrock model import.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
