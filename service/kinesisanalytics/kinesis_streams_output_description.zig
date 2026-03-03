/// For an application output, describes
/// the Amazon Kinesis stream configured as its destination.
pub const KinesisStreamsOutputDescription = struct {
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
