/// The configuration information for the Amazon Q in Connect assistant
/// integration.
pub const AssistantIntegrationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the integrated Amazon SNS topic used for
    /// streaming chat messages.
    topic_integration_arn: ?[]const u8,

    pub const json_field_names = .{
        .topic_integration_arn = "topicIntegrationArn",
    };
};
