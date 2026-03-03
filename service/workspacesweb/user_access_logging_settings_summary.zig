/// The summary of user access logging settings.
pub const UserAccessLoggingSettingsSummary = struct {
    /// The ARN of the Kinesis stream.
    kinesis_stream_arn: ?[]const u8 = null,

    /// The ARN of the user access logging settings.
    user_access_logging_settings_arn: []const u8,

    pub const json_field_names = .{
        .kinesis_stream_arn = "kinesisStreamArn",
        .user_access_logging_settings_arn = "userAccessLoggingSettingsArn",
    };
};
