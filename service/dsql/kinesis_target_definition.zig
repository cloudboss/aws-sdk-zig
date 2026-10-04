/// Kinesis stream target configuration.
pub const KinesisTargetDefinition = struct {
    /// The ARN of the IAM role that grants permission to write to the Kinesis
    /// stream. This can be a standard role
    /// (`arn:aws:iam::account-id:role/role-name`) or a role with a path prefix
    /// (`arn:aws:iam::account-id:role/service-role/role-name`), such as roles
    /// auto-created by the console.
    role_arn: []const u8,

    /// The ARN of the Kinesis stream.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .stream_arn = "streamArn",
    };
};
