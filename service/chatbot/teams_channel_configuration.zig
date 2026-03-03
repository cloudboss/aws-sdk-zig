const Tag = @import("tag.zig").Tag;

/// An AWS Chatbot configuration for Microsoft Teams.
pub const TeamsChannelConfiguration = struct {
    /// The ID of the Microsoft Teams channel.
    channel_id: []const u8,

    /// The name of the Microsoft Teams channel.
    channel_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the MicrosoftTeamsChannelConfiguration
    /// associated with the user identity to delete.
    chat_configuration_arn: []const u8,

    /// The name of the configuration.
    configuration_name: ?[]const u8 = null,

    /// The list of IAM policy ARNs that are applied as channel guardrails. The AWS
    /// managed `AdministratorAccess` policy is applied by default if this is not
    /// set.
    guardrail_policy_arns: ?[]const []const u8 = null,

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

    /// The ID of the Microsoft Teams authorized with AWS Chatbot.
    ///
    /// To get the team ID, you must perform the initial authorization flow with
    /// Microsoft Teams in the AWS Chatbot console. Then you can copy and paste the
    /// team ID from the console. For more information, see [Step 1: Configure a
    /// Microsoft Teams
    /// client](https://docs.aws.amazon.com/chatbot/latest/adminguide/teams-setup.html#teams-client-setup) in the * AWS Chatbot Administrator Guide*.
    team_id: []const u8,

    /// The name of the Microsoft Teams Team.
    team_name: ?[]const u8 = null,

    /// The ID of the Microsoft Teams tenant.
    tenant_id: []const u8,

    /// Enables use of a user role requirement in your chat configuration.
    user_authorization_required: ?bool = null,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .channel_name = "ChannelName",
        .chat_configuration_arn = "ChatConfigurationArn",
        .configuration_name = "ConfigurationName",
        .guardrail_policy_arns = "GuardrailPolicyArns",
        .iam_role_arn = "IamRoleArn",
        .logging_level = "LoggingLevel",
        .sns_topic_arns = "SnsTopicArns",
        .state = "State",
        .state_reason = "StateReason",
        .tags = "Tags",
        .team_id = "TeamId",
        .team_name = "TeamName",
        .tenant_id = "TenantId",
        .user_authorization_required = "UserAuthorizationRequired",
    };
};
