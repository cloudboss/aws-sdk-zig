const LogSettingsRequest = @import("log_settings_request.zig").LogSettingsRequest;

/// Provides the settings needed for conversation logs.
pub const ConversationLogsRequest = struct {
    /// The Amazon Resource Name (ARN) of an IAM role with permission to write
    /// to your CloudWatch Logs for text logs and your S3 bucket for audio logs.
    /// If audio encryption is enabled, this role also provides access permission
    /// for the AWS KMS key used for encrypting audio logs. For more information,
    /// see [Creating an
    /// IAM Role and Policy for Conversation
    /// Logs](https://docs.aws.amazon.com/lex/latest/dg/conversation-logs-role-and-policy.html).
    iam_role_arn: []const u8,

    /// The settings for your conversation logs. You can log the conversation
    /// text, conversation audio, or both.
    log_settings: []const LogSettingsRequest,

    pub const json_field_names = .{
        .iam_role_arn = "iamRoleArn",
        .log_settings = "logSettings",
    };
};
