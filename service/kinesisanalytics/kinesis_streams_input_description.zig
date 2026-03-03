/// Describes the Amazon Kinesis stream that is configured as the streaming
/// source
/// in the application input configuration.
pub const KinesisStreamsInputDescription = struct {
    /// Amazon Resource Name (ARN) of the Amazon Kinesis stream.
    resource_arn: ?[]const u8 = null,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to access the
    /// stream.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};
