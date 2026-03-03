/// Identifes a user level permission for a channel configuration.
pub const TeamsUserIdentity = struct {
    /// The AWS user identity ARN used to associate a Microsoft Teams user Identity
    /// with an IAM Role.
    aws_user_identity: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the MicrosoftTeamsChannelConfiguration
    /// associated with the user identity to delete.
    chat_configuration_arn: []const u8,

    /// A user-defined role that AWS Chatbot assumes. This is not the service-linked
    /// role.
    ///
    /// For more information, see [IAM policies for AWS
    /// Chatbot](https://docs.aws.amazon.com/chatbot/latest/adminguide/chatbot-iam-policies.html) in the * AWS Chatbot Administrator Guide*.
    iam_role_arn: []const u8,

    /// The ID of the Microsoft Teams authorized with AWS Chatbot.
    ///
    /// To get the team ID, you must perform the initial authorization flow with
    /// Microsoft Teams in the AWS Chatbot console. Then you can copy and paste the
    /// team ID from the console. For more information, see [Step 1: Configure a
    /// Microsoft Teams
    /// client](https://docs.aws.amazon.com/chatbot/latest/adminguide/teams-setup.html#teams-client-setup) in the * AWS Chatbot Administrator Guide*.
    team_id: []const u8,

    /// The ID of the Microsoft Teams channel.
    teams_channel_id: ?[]const u8 = null,

    /// The ID of the Microsoft Teams tenant.
    teams_tenant_id: ?[]const u8 = null,

    /// The Microsoft Teams user ID.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_user_identity = "AwsUserIdentity",
        .chat_configuration_arn = "ChatConfigurationArn",
        .iam_role_arn = "IamRoleArn",
        .team_id = "TeamId",
        .teams_channel_id = "TeamsChannelId",
        .teams_tenant_id = "TeamsTenantId",
        .user_id = "UserId",
    };
};
