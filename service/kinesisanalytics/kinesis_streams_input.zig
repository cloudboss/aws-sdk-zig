/// Identifies an Amazon Kinesis stream as the streaming source. You provide the
/// stream's Amazon Resource Name (ARN) and an IAM role ARN that enables Amazon
/// Kinesis
/// Analytics to access the stream on your behalf.
pub const KinesisStreamsInput = struct {
    /// ARN of the input Amazon Kinesis stream to read.
    resource_arn: []const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to access the
    /// stream on your behalf. You need to grant the necessary permissions to this
    /// role.
    role_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};
