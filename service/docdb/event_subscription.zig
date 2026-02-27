/// Detailed information about an event to which you have subscribed.
pub const EventSubscription = struct {
    /// The Amazon Web Services customer account that is associated with the Amazon
    /// DocumentDB event notification
    /// subscription.
    customer_aws_id: ?[]const u8,

    /// The Amazon DocumentDB event notification subscription ID.
    cust_subscription_id: ?[]const u8,

    /// A Boolean value indicating whether the subscription is enabled. A value of
    /// `true` indicates that the subscription is enabled.
    enabled: ?bool,

    /// A list of event categories for the Amazon DocumentDB event notification
    /// subscription.
    event_categories_list: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) for the event subscription.
    event_subscription_arn: ?[]const u8,

    /// The topic ARN of the Amazon DocumentDB event notification subscription.
    sns_topic_arn: ?[]const u8,

    /// A list of source IDs for the Amazon DocumentDB event notification
    /// subscription.
    source_ids_list: ?[]const []const u8,

    /// The source type for the Amazon DocumentDB event notification subscription.
    source_type: ?[]const u8,

    /// The status of the Amazon DocumentDB event notification subscription.
    ///
    /// Constraints:
    ///
    /// Can be one of the following: `creating`, `modifying`,
    /// `deleting`, `active`, `no-permission`,
    /// `topic-not-exist`
    ///
    /// The `no-permission` status indicates that Amazon DocumentDB no longer has
    /// permission
    /// to post to the SNS topic. The `topic-not-exist` status indicates that the
    /// topic was deleted after the subscription was created.
    status: ?[]const u8,

    /// The time at which the Amazon DocumentDB event notification subscription was
    /// created.
    subscription_creation_time: ?[]const u8,
};
