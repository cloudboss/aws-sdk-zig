/// The proposed access control configuration for an Amazon SNS topic. You can
/// propose a configuration for a new Amazon SNS topic or an existing Amazon SNS
/// topic that you own by specifying the policy. If the configuration is for an
/// existing Amazon SNS topic and you do not specify the Amazon SNS policy, then
/// the access preview uses the existing Amazon SNS policy for the topic. If the
/// access preview is for a new resource and you do not specify the policy, then
/// the access preview assumes an Amazon SNS topic without a policy. To propose
/// deletion of an existing Amazon SNS topic policy, you can specify an empty
/// string for the Amazon SNS policy. For more information, see
/// [Topic](https://docs.aws.amazon.com/sns/latest/api/API_Topic.html).
pub const SnsTopicConfiguration = struct {
    /// The JSON policy text that defines who can access an Amazon SNS topic. For
    /// more information, see [Example cases for Amazon SNS access
    /// control](https://docs.aws.amazon.com/sns/latest/dg/sns-access-policy-use-cases.html) in the *Amazon SNS Developer Guide*.
    topic_policy: ?[]const u8,

    pub const json_field_names = .{
        .topic_policy = "topicPolicy",
    };
};
