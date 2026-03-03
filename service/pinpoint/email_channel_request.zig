/// Specifies the status and settings of the email channel for an application.
pub const EmailChannelRequest = struct {
    /// The [Amazon SES configuration
    /// set](https://docs.aws.amazon.com/ses/latest/APIReference/API_ConfigurationSet.html) that you want to apply to messages that you send through the channel.
    configuration_set: ?[]const u8 = null,

    /// Specifies whether to enable the email channel for the application.
    enabled: ?bool = null,

    /// The verified email address that you want to send email from when you send
    /// email through the channel.
    from_address: []const u8,

    /// The Amazon Resource Name (ARN) of the identity, verified with Amazon Simple
    /// Email Service (Amazon SES), that you want to use when you send email through
    /// the channel.
    identity: []const u8,

    /// The ARN of an IAM role for Amazon Pinpoint to use to send email from your
    /// campaigns or journeys through Amazon SES.
    orchestration_sending_role_arn: ?[]const u8 = null,

    /// The ARN of the AWS Identity and Access Management (IAM) role that you want
    /// Amazon Pinpoint to use when it submits email-related event data for the
    /// channel.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_set = "ConfigurationSet",
        .enabled = "Enabled",
        .from_address = "FromAddress",
        .identity = "Identity",
        .orchestration_sending_role_arn = "OrchestrationSendingRoleArn",
        .role_arn = "RoleArn",
    };
};
