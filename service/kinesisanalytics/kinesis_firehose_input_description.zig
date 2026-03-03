/// Describes the Amazon Kinesis Firehose delivery stream that is configured as
/// the streaming source
/// in the application input configuration.
pub const KinesisFirehoseInputDescription = struct {
    /// Amazon Resource Name (ARN) of the Amazon Kinesis Firehose delivery stream.
    resource_arn: ?[]const u8 = null,

    /// ARN of the IAM role that Amazon Kinesis Analytics assumes to access the
    /// stream.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};
