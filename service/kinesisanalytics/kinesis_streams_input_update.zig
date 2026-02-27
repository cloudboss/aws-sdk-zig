/// When updating application input configuration, provides information about an
/// Amazon Kinesis stream as the streaming source.
pub const KinesisStreamsInputUpdate = struct {
    /// Amazon Resource Name (ARN) of the input Amazon Kinesis stream to read.
    resource_arn_update: ?[]const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to access the
    /// stream on your behalf. You need to grant the necessary permissions to this
    /// role.
    role_arn_update: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
        .role_arn_update = "RoleARNUpdate",
    };
};
