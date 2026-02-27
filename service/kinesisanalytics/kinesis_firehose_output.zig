/// When configuring application output,
/// identifies an Amazon Kinesis Firehose delivery stream as the destination.
/// You provide the stream Amazon Resource Name (ARN) and an IAM role
/// that enables Amazon Kinesis Analytics to write to the stream on your behalf.
pub const KinesisFirehoseOutput = struct {
    /// ARN of the destination Amazon Kinesis Firehose delivery stream to write to.
    resource_arn: []const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to write to the
    /// destination stream on your behalf. You need to grant the necessary
    /// permissions to this role.
    role_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};
