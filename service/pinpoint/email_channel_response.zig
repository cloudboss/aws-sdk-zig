/// Provides information about the status and settings of the email channel for
/// an application.
pub const EmailChannelResponse = struct {
    /// The unique identifier for the application that the email channel applies to.
    application_id: ?[]const u8,

    /// The [Amazon SES configuration
    /// set](https://docs.aws.amazon.com/ses/latest/APIReference/API_ConfigurationSet.html) that's applied to messages that are sent through the channel.
    configuration_set: ?[]const u8,

    /// The date and time, in ISO 8601 format, when the email channel was enabled.
    creation_date: ?[]const u8,

    /// Specifies whether the email channel is enabled for the application.
    enabled: ?bool,

    /// The verified email address that email is sent from when you send email
    /// through the channel.
    from_address: ?[]const u8,

    /// (Not used) This property is retained only for backward compatibility.
    has_credential: ?bool,

    /// (Deprecated) An identifier for the email channel. This property is retained
    /// only for backward compatibility.
    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the identity, verified with Amazon Simple
    /// Email Service (Amazon SES), that's used when you send email through the
    /// channel.
    identity: ?[]const u8,

    /// Specifies whether the email channel is archived.
    is_archived: ?bool,

    /// The user who last modified the email channel.
    last_modified_by: ?[]const u8,

    /// The date and time, in ISO 8601 format, when the email channel was last
    /// modified.
    last_modified_date: ?[]const u8,

    /// The maximum number of emails that can be sent through the channel each
    /// second.
    messages_per_second: ?i32,

    /// The ARN of an IAM role for Amazon Pinpoint to use to send email from your
    /// campaigns or journeys through Amazon SES.
    orchestration_sending_role_arn: ?[]const u8,

    /// The type of messaging or notification platform for the channel. For the
    /// email channel, this value is EMAIL.
    platform: []const u8,

    /// The ARN of the AWS Identity and Access Management (IAM) role that Amazon
    /// Pinpoint uses to submit email-related event data for the channel.
    role_arn: ?[]const u8,

    /// The current version of the email channel.
    version: ?i32,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_set = "ConfigurationSet",
        .creation_date = "CreationDate",
        .enabled = "Enabled",
        .from_address = "FromAddress",
        .has_credential = "HasCredential",
        .id = "Id",
        .identity = "Identity",
        .is_archived = "IsArchived",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .messages_per_second = "MessagesPerSecond",
        .orchestration_sending_role_arn = "OrchestrationSendingRoleArn",
        .platform = "Platform",
        .role_arn = "RoleArn",
        .version = "Version",
    };
};
