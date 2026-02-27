const MessageFormat = @import("message_format.zig").MessageFormat;

/// Describes an action to publish to an Amazon SNS topic.
pub const SnsAction = struct {
    /// (Optional) The message format of the message to publish. Accepted values are
    /// "JSON"
    /// and "RAW". The default value of the attribute is "RAW". SNS uses this
    /// setting to determine
    /// if the payload should be parsed and relevant platform-specific bits of the
    /// payload should
    /// be extracted. To read more about SNS message formats, see
    /// [https://docs.aws.amazon.com/sns/latest/dg/json-formats.html](https://docs.aws.amazon.com/sns/latest/dg/json-formats.html) refer to their official documentation.
    message_format: ?MessageFormat,

    /// The ARN of the IAM role that grants access.
    role_arn: []const u8,

    /// The ARN of the SNS topic.
    target_arn: []const u8,

    pub const json_field_names = .{
        .message_format = "messageFormat",
        .role_arn = "roleArn",
        .target_arn = "targetArn",
    };
};
