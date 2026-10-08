/// Configuration for bidirectional Slack communication.
pub const SlackBidirectionalConfiguration = struct {
    /// Whether bidirectional communication is enabled for this association. When
    /// you set this value to true, you can mention the agent in a configured Slack
    /// channel and it responds in that channel. When you omit this value or set it
    /// to false, the agent ignores mentions and only sends notifications.
    enabled: ?bool = null,

    /// IAM role ARN that AWS DevOps Agent assumes to exchange messages with your
    /// Slack workspace on behalf of this association.
    role_arn: []const u8,

    pub const json_field_names = .{
        .enabled = "enabled",
        .role_arn = "roleArn",
    };
};
