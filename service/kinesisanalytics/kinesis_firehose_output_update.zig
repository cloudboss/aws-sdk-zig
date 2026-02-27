/// When updating an output configuration using the
/// [UpdateApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_UpdateApplication.html) operation,
/// provides information about an Amazon Kinesis Firehose delivery stream
/// configured as
/// the destination.
pub const KinesisFirehoseOutputUpdate = struct {
    /// Amazon Resource Name (ARN) of the Amazon Kinesis Firehose delivery stream to
    /// write to.
    resource_arn_update: ?[]const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to access the
    /// stream
    /// on your behalf. You need to grant the necessary permissions to this role.
    role_arn_update: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
        .role_arn_update = "RoleARNUpdate",
    };
};
