const AwsSnsTopicSubscription = @import("aws_sns_topic_subscription.zig").AwsSnsTopicSubscription;

/// Provides information about an Amazon SNS topic to which notifications can be
/// published.
pub const AwsSnsTopicDetails = struct {
    /// Indicates failed message delivery status for an Amazon SNS topic that is
    /// subscribed to a platform application endpoint.
    application_success_feedback_role_arn: ?[]const u8,

    /// Indicates failed message delivery status for an Amazon SNS topic that is
    /// subscribed to an Amazon Kinesis Data Firehose endpoint.
    firehose_failure_feedback_role_arn: ?[]const u8,

    /// Indicates successful message delivery status for an Amazon SNS topic that is
    /// subscribed to an Amazon Kinesis Data Firehose endpoint.
    firehose_success_feedback_role_arn: ?[]const u8,

    /// Indicates failed message delivery status for an Amazon SNS topic that is
    /// subscribed to an HTTP endpoint.
    http_failure_feedback_role_arn: ?[]const u8,

    /// Indicates successful message delivery status for an Amazon SNS topic that is
    /// subscribed to an HTTP endpoint.
    http_success_feedback_role_arn: ?[]const u8,

    /// The ID of an Amazon Web Services managed key for Amazon SNS or a customer
    /// managed key.
    kms_master_key_id: ?[]const u8,

    /// The subscription's owner.
    owner: ?[]const u8,

    /// Indicates failed message delivery status for an Amazon SNS topic that is
    /// subscribed to an Amazon SQS endpoint.
    sqs_failure_feedback_role_arn: ?[]const u8,

    /// Indicates successful message delivery status for an Amazon SNS topic that is
    /// subscribed to an Amazon SQS endpoint.
    sqs_success_feedback_role_arn: ?[]const u8,

    /// Subscription is an embedded property that describes the subscription
    /// endpoints of an Amazon SNS topic.
    subscription: ?[]const AwsSnsTopicSubscription,

    /// The name of the Amazon SNS topic.
    topic_name: ?[]const u8,

    pub const json_field_names = .{
        .application_success_feedback_role_arn = "ApplicationSuccessFeedbackRoleArn",
        .firehose_failure_feedback_role_arn = "FirehoseFailureFeedbackRoleArn",
        .firehose_success_feedback_role_arn = "FirehoseSuccessFeedbackRoleArn",
        .http_failure_feedback_role_arn = "HttpFailureFeedbackRoleArn",
        .http_success_feedback_role_arn = "HttpSuccessFeedbackRoleArn",
        .kms_master_key_id = "KmsMasterKeyId",
        .owner = "Owner",
        .sqs_failure_feedback_role_arn = "SqsFailureFeedbackRoleArn",
        .sqs_success_feedback_role_arn = "SqsSuccessFeedbackRoleArn",
        .subscription = "Subscription",
        .topic_name = "TopicName",
    };
};
