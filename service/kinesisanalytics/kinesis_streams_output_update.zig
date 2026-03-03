/// When updating an output configuration using the
/// [UpdateApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_UpdateApplication.html) operation,
/// provides information about an Amazon Kinesis stream configured as
/// the destination.
pub const KinesisStreamsOutputUpdate = struct {
    /// Amazon Resource Name (ARN) of the Amazon Kinesis stream where you want to
    /// write the output.
    resource_arn_update: ?[]const u8 = null,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to access the
    /// stream on your behalf. You need to grant the necessary permissions to this
    /// role.
    role_arn_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
        .role_arn_update = "RoleARNUpdate",
    };
};
