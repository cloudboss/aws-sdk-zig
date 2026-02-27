/// For an application output, describes
/// the Amazon Kinesis Firehose delivery stream configured as its destination.
pub const KinesisFirehoseOutputDescription = struct {
    /// Amazon Resource Name (ARN) of the Amazon Kinesis Firehose delivery stream.
    resource_arn: ?[]const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to access the
    /// stream.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};
