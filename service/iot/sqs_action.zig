/// Describes an action to publish data to an Amazon SQS queue.
pub const SqsAction = struct {
    /// The URL of the Amazon SQS queue.
    queue_url: []const u8,

    /// The ARN of the IAM role that grants access.
    role_arn: []const u8,

    /// Specifies whether to use Base64 encoding.
    use_base_64: ?bool = null,

    pub const json_field_names = .{
        .queue_url = "queueUrl",
        .role_arn = "roleArn",
        .use_base_64 = "useBase64",
    };
};
