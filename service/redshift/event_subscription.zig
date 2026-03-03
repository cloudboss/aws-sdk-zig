const Tag = @import("tag.zig").Tag;

/// Describes event subscriptions.
pub const EventSubscription = struct {
    /// The Amazon Web Services account associated with the Amazon Redshift event
    /// notification
    /// subscription.
    customer_aws_id: ?[]const u8 = null,

    /// The name of the Amazon Redshift event notification subscription.
    cust_subscription_id: ?[]const u8 = null,

    /// A boolean value indicating whether the subscription is enabled; `true`
    /// indicates that the subscription is enabled.
    enabled: ?bool = null,

    /// The list of Amazon Redshift event categories specified in the event
    /// notification
    /// subscription.
    ///
    /// Values: Configuration, Management, Monitoring, Security, Pending
    event_categories_list: ?[]const []const u8 = null,

    /// The event severity specified in the Amazon Redshift event notification
    /// subscription.
    ///
    /// Values: ERROR, INFO
    severity: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic used by the event
    /// notification subscription.
    sns_topic_arn: ?[]const u8 = null,

    /// A list of the sources that publish events to the Amazon Redshift event
    /// notification
    /// subscription.
    source_ids_list: ?[]const []const u8 = null,

    /// The source type of the events returned by the Amazon Redshift event
    /// notification, such as
    /// cluster, cluster-snapshot, cluster-parameter-group, cluster-security-group,
    /// or scheduled-action.
    source_type: ?[]const u8 = null,

    /// The status of the Amazon Redshift event notification subscription.
    ///
    /// Constraints:
    ///
    /// * Can be one of the following: active | no-permission |
    /// topic-not-exist
    ///
    /// * The status "no-permission" indicates that Amazon Redshift no longer has
    /// permission to post to the Amazon SNS topic. The status "topic-not-exist"
    /// indicates that the topic was deleted after the subscription was
    /// created.
    status: ?[]const u8 = null,

    /// The date and time the Amazon Redshift event notification subscription was
    /// created.
    subscription_creation_time: ?i64 = null,

    /// The list of tags for the event subscription.
    tags: ?[]const Tag = null,
};
