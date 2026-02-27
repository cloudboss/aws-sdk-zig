/// Parameters to define a mitigation action that publishes findings to Amazon
/// SNS. You can implement your own custom actions in response to the Amazon SNS
/// messages.
pub const PublishFindingToSnsParams = struct {
    /// The ARN of the topic to which you want to publish the findings.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .topic_arn = "topicArn",
    };
};
