const LogSettingsResponse = @import("log_settings_response.zig").LogSettingsResponse;

/// Contains information about conversation log settings.
pub const ConversationLogsResponse = struct {
    /// The Amazon Resource Name (ARN) of the IAM role used to write your logs
    /// to CloudWatch Logs or an S3 bucket.
    iam_role_arn: ?[]const u8 = null,

    /// The settings for your conversation logs. You can log text, audio, or
    /// both.
    log_settings: ?[]const LogSettingsResponse = null,

    pub const json_field_names = .{
        .iam_role_arn = "iamRoleArn",
        .log_settings = "logSettings",
    };
};
