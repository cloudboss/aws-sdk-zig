/// Describes an action to write data to an Amazon Kinesis stream.
pub const KinesisAction = struct {
    /// The partition key.
    partition_key: ?[]const u8,

    /// The ARN of the IAM role that grants access to the Amazon Kinesis stream.
    role_arn: []const u8,

    /// The name of the Amazon Kinesis stream.
    stream_name: []const u8,

    pub const json_field_names = .{
        .partition_key = "partitionKey",
        .role_arn = "roleArn",
        .stream_name = "streamName",
    };
};
