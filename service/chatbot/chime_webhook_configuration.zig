const Tag = @import("tag.zig").Tag;

/// An AWS Chatbot configuration for Amazon Chime.
pub const ChimeWebhookConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the ChimeWebhookConfiguration.
    chat_configuration_arn: []const u8,

    /// The name of the configuration.
    configuration_name: ?[]const u8 = null,

    /// A user-defined role that AWS Chatbot assumes. This is not the service-linked
    /// role.
    ///
    /// For more information, see [IAM policies for AWS
    /// Chatbot](https://docs.aws.amazon.com/chatbot/latest/adminguide/chatbot-iam-policies.html) in the * AWS Chatbot Administrator Guide*.
    iam_role_arn: []const u8,

    /// Logging levels include `ERROR`, `INFO`, or `NONE`.
    logging_level: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the SNS topics that deliver
    /// notifications to AWS Chatbot.
    sns_topic_arns: []const []const u8,

    /// Either `ENABLED` or `DISABLED`. The resource returns `DISABLED` if the
    /// organization's AWS Chatbot policy has explicitly denied that configuration.
    /// For example, if Amazon Chime is disabled.
    state: ?[]const u8 = null,

    /// Provided if State is `DISABLED`. Provides context as to why the resource is
    /// disabled.
    state_reason: ?[]const u8 = null,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: ?[]const Tag = null,

    /// A description of the webhook. We recommend using the convention
    /// `RoomName/WebhookName`.
    ///
    /// For more information, see [Tutorial: Get started with Amazon
    /// Chime](https://docs.aws.amazon.com/chatbot/latest/adminguide/chime-setup.html) in the * AWS Chatbot Administrator Guide*.
    webhook_description: []const u8,

    pub const json_field_names = .{
        .chat_configuration_arn = "ChatConfigurationArn",
        .configuration_name = "ConfigurationName",
        .iam_role_arn = "IamRoleArn",
        .logging_level = "LoggingLevel",
        .sns_topic_arns = "SnsTopicArns",
        .state = "State",
        .state_reason = "StateReason",
        .tags = "Tags",
        .webhook_description = "WebhookDescription",
    };
};
