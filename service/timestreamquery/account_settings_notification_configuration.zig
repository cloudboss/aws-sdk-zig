const SnsConfiguration = @import("sns_configuration.zig").SnsConfiguration;

/// Configuration settings for notifications related to account settings.
pub const AccountSettingsNotificationConfiguration = struct {
    /// An Amazon Resource Name (ARN) that grants Timestream permission to publish
    /// notifications. This field is only visible if SNS Topic is provided when
    /// updating the account settings.
    role_arn: []const u8,

    sns_configuration: ?SnsConfiguration,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .sns_configuration = "SnsConfiguration",
    };
};
