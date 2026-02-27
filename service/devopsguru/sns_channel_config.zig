/// Contains the Amazon Resource Name (ARN) of an Amazon Simple Notification
/// Service topic.
///
/// If you use an Amazon SNS topic in another account, you must attach a policy
/// to it that grants DevOps Guru permission
/// to send it notifications. DevOps Guru adds the required policy on your
/// behalf to send notifications using Amazon SNS in your account. DevOps Guru
/// only supports standard SNS topics.
/// For more information, see [Permissions
/// for Amazon SNS
/// topics](https://docs.aws.amazon.com/devops-guru/latest/userguide/sns-required-permissions.html).
///
/// If you use an Amazon SNS topic that is encrypted by an Amazon Web Services
/// Key Management Service customer-managed key (CMK), then you must add
/// permissions
/// to the CMK. For more information, see [Permissions for
/// Amazon Web Services KMS–encrypted Amazon SNS
/// topics](https://docs.aws.amazon.com/devops-guru/latest/userguide/sns-kms-permissions.html).
pub const SnsChannelConfig = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Simple Notification Service
    /// topic.
    topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .topic_arn = "TopicArn",
    };
};
