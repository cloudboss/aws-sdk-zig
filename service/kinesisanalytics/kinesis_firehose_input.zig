/// Identifies an Amazon Kinesis Firehose delivery stream as the streaming
/// source. You
/// provide the delivery stream's Amazon Resource Name (ARN) and an IAM role ARN
/// that
/// enables Amazon Kinesis Analytics to access the stream on your behalf.
pub const KinesisFirehoseInput = struct {
    /// ARN of the input delivery stream.
    resource_arn: []const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to access the
    /// stream
    /// on your behalf. You need to make sure that the role has the necessary
    /// permissions to
    /// access the stream.
    role_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};
