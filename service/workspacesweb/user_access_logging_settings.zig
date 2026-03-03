/// A user access logging settings resource that can be associated with a web
/// portal.
pub const UserAccessLoggingSettings = struct {
    /// A list of web portal ARNs that this user access logging settings is
    /// associated with.
    associated_portal_arns: ?[]const []const u8 = null,

    /// The ARN of the Kinesis stream.
    kinesis_stream_arn: ?[]const u8 = null,

    /// The ARN of the user access logging settings.
    user_access_logging_settings_arn: []const u8,

    pub const json_field_names = .{
        .associated_portal_arns = "associatedPortalArns",
        .kinesis_stream_arn = "kinesisStreamArn",
        .user_access_logging_settings_arn = "userAccessLoggingSettingsArn",
    };
};
