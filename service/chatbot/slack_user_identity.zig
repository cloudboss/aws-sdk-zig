/// Identifes a user level permission for a channel configuration.
pub const SlackUserIdentity = struct {
    /// The AWS user identity ARN used to associate a Slack user ID with an IAM
    /// Role.
    aws_user_identity: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the SlackChannelConfiguration associated
    /// with the user identity to delete.
    chat_configuration_arn: []const u8,

    /// A user-defined role that AWS Chatbot assumes. This is not the service-linked
    /// role.
    ///
    /// For more information, see [IAM policies for AWS
    /// Chatbot](https://docs.aws.amazon.com/chatbot/latest/adminguide/chatbot-iam-policies.html) in the * AWS Chatbot Administrator Guide*.
    iam_role_arn: []const u8,

    /// The ID of the Slack workspace authorized with AWS Chatbot.
    slack_team_id: []const u8,

    /// The ID of the user in Slack
    slack_user_id: []const u8,

    pub const json_field_names = .{
        .aws_user_identity = "AwsUserIdentity",
        .chat_configuration_arn = "ChatConfigurationArn",
        .iam_role_arn = "IamRoleArn",
        .slack_team_id = "SlackTeamId",
        .slack_user_id = "SlackUserId",
    };
};
