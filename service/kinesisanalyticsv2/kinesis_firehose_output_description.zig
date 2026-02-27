/// For a SQL-based Kinesis Data Analytics application's output, describes the
/// Kinesis
/// Data Firehose delivery stream that is configured as its destination.
pub const KinesisFirehoseOutputDescription = struct {
    /// The Amazon Resource Name (ARN) of the delivery stream.
    resource_arn: []const u8,

    /// The ARN of the IAM role that Kinesis Data Analytics can assume to access the
    /// stream.
    ///
    /// Provided for backward compatibility. Applications that are created with the
    /// current API
    /// version have an application-level service execution role rather than a
    /// resource-level
    /// role.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};
