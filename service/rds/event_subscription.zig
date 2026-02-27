/// Contains the results of a successful invocation of the
/// `DescribeEventSubscriptions` action.
pub const EventSubscription = struct {
    /// The Amazon Web Services customer account associated with the RDS event
    /// notification subscription.
    customer_aws_id: ?[]const u8,

    /// The RDS event notification subscription Id.
    cust_subscription_id: ?[]const u8,

    /// Specifies whether the subscription is enabled. True indicates the
    /// subscription is enabled.
    enabled: ?bool,

    /// A list of event categories for the RDS event notification subscription.
    event_categories_list: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) for the event subscription.
    event_subscription_arn: ?[]const u8,

    /// The topic ARN of the RDS event notification subscription.
    sns_topic_arn: ?[]const u8,

    /// A list of source IDs for the RDS event notification subscription.
    source_ids_list: ?[]const []const u8,

    /// The source type for the RDS event notification subscription.
    source_type: ?[]const u8,

    /// The status of the RDS event notification subscription.
    ///
    /// Constraints:
    ///
    /// Can be one of the following: creating | modifying | deleting | active |
    /// no-permission | topic-not-exist
    ///
    /// The status "no-permission" indicates that RDS no longer has permission to
    /// post to the SNS topic. The status "topic-not-exist" indicates that the topic
    /// was deleted after the subscription was created.
    status: ?[]const u8,

    /// The time the RDS event notification subscription was created.
    subscription_creation_time: ?[]const u8,
};
