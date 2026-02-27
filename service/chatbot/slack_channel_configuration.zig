const Tag = @import("tag.zig").Tag;

/// An AWS Chatbot configuration for Slack.
pub const SlackChannelConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the SlackChannelConfiguration.
    chat_configuration_arn: []const u8,

    /// The name of the configuration.
    configuration_name: ?[]const u8,

    /// The list of IAM policy ARNs that are applied as channel guardrails. The AWS
    /// managed `AdministratorAccess` policy is applied by default if this is not
    /// set.
    guardrail_policy_arns: ?[]const []const u8,

    /// A user-defined role that AWS Chatbot assumes. This is not the service-linked
    /// role.
    ///
    /// For more information, see [IAM policies for AWS
    /// Chatbot](https://docs.aws.amazon.com/chatbot/latest/adminguide/chatbot-iam-policies.html) in the * AWS Chatbot Administrator Guide*.
    iam_role_arn: []const u8,

    /// Logging levels include `ERROR`, `INFO`, or `NONE`.
    logging_level: ?[]const u8,

    /// The ID of the Slack channel.
    ///
    /// To get this ID, open Slack, right click on the channel name in the left
    /// pane, then choose Copy Link. The channel ID is the 9-character string at the
    /// end of the URL. For example, ABCBBLZZZ.
    slack_channel_id: []const u8,

    /// The name of the Slack channel.
    slack_channel_name: []const u8,

    /// The ID of the Slack workspace authorized with Amazon Chime.
    slack_team_id: []const u8,

    /// Name of the Slack workspace.
    slack_team_name: []const u8,

    /// The ARNs of the SNS topics that deliver notifications to AWS Chatbot.
    sns_topic_arns: []const []const u8,

    /// Either `ENABLED` or `DISABLED`. The resource returns `DISABLED` if the
    /// organization's AWS Chatbot policy has explicitly denied that configuration.
    /// For example, if Amazon Chime is disabled.
    state: ?[]const u8,

    /// Provided if State is `DISABLED`. Provides context as to why the resource is
    /// disabled.
    state_reason: ?[]const u8,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: ?[]const Tag,

    /// Enables use of a user role requirement in your chat configuration.
    user_authorization_required: ?bool,

    pub const json_field_names = .{
        .chat_configuration_arn = "ChatConfigurationArn",
        .configuration_name = "ConfigurationName",
        .guardrail_policy_arns = "GuardrailPolicyArns",
        .iam_role_arn = "IamRoleArn",
        .logging_level = "LoggingLevel",
        .slack_channel_id = "SlackChannelId",
        .slack_channel_name = "SlackChannelName",
        .slack_team_id = "SlackTeamId",
        .slack_team_name = "SlackTeamName",
        .sns_topic_arns = "SnsTopicArns",
        .state = "State",
        .state_reason = "StateReason",
        .tags = "Tags",
        .user_authorization_required = "UserAuthorizationRequired",
    };
};
