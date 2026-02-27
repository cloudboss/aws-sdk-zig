/// The configuration information for the session integration.
pub const SessionIntegrationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the integrated Amazon SNS topic used for
    /// streaming chat messages.
    topic_integration_arn: ?[]const u8,

    pub const json_field_names = .{
        .topic_integration_arn = "topicIntegrationArn",
    };
};
