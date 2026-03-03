/// Contains the results of a successful invocation of the
/// DescribeEventSubscriptions action.
pub const EventSubscription = struct {
    /// The Amazon customer account associated with the event notification
    /// subscription.
    customer_aws_id: ?[]const u8 = null,

    /// The event notification subscription Id.
    cust_subscription_id: ?[]const u8 = null,

    /// A Boolean value indicating if the subscription is enabled. True indicates
    /// the subscription
    /// is enabled.
    enabled: ?bool = null,

    /// A list of event categories for the event notification subscription.
    event_categories_list: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) for the event subscription.
    event_subscription_arn: ?[]const u8 = null,

    /// The topic ARN of the event notification subscription.
    sns_topic_arn: ?[]const u8 = null,

    /// A list of source IDs for the event notification subscription.
    source_ids_list: ?[]const []const u8 = null,

    /// The source type for the event notification subscription.
    source_type: ?[]const u8 = null,

    /// The status of the event notification subscription.
    ///
    /// Constraints:
    ///
    /// Can be one of the following: creating | modifying | deleting | active |
    /// no-permission |
    /// topic-not-exist
    ///
    /// The status "no-permission" indicates that Neptune no longer has permission
    /// to post to the
    /// SNS topic. The status "topic-not-exist" indicates that the topic was deleted
    /// after the
    /// subscription was created.
    status: ?[]const u8 = null,

    /// The time the event notification subscription was created.
    subscription_creation_time: ?[]const u8 = null,
};
