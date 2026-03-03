/// Describes an event notification subscription created by the
/// `CreateEventSubscription` operation.
pub const EventSubscription = struct {
    /// The Amazon Web Services customer account associated with the DMS event
    /// notification
    /// subscription.
    customer_aws_id: ?[]const u8 = null,

    /// The DMS event notification subscription Id.
    cust_subscription_id: ?[]const u8 = null,

    /// Boolean value that indicates if the event subscription is enabled.
    enabled: bool = false,

    /// A lists of event categories.
    event_categories_list: ?[]const []const u8 = null,

    /// The topic ARN of the DMS event notification subscription.
    sns_topic_arn: ?[]const u8 = null,

    /// A list of source Ids for the event subscription.
    source_ids_list: ?[]const []const u8 = null,

    /// The type of DMS resource that generates events.
    ///
    /// Valid values: replication-instance | replication-server | security-group |
    /// replication-task
    source_type: ?[]const u8 = null,

    /// The status of the DMS event notification subscription.
    ///
    /// Constraints:
    ///
    /// Can be one of the following: creating | modifying | deleting | active |
    /// no-permission |
    /// topic-not-exist
    ///
    /// The status "no-permission" indicates that DMS no longer has permission to
    /// post to the
    /// SNS topic. The status "topic-not-exist" indicates that the topic was deleted
    /// after the
    /// subscription was created.
    status: ?[]const u8 = null,

    /// The time the DMS event notification subscription was created.
    subscription_creation_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_aws_id = "CustomerAwsId",
        .cust_subscription_id = "CustSubscriptionId",
        .enabled = "Enabled",
        .event_categories_list = "EventCategoriesList",
        .sns_topic_arn = "SnsTopicArn",
        .source_ids_list = "SourceIdsList",
        .source_type = "SourceType",
        .status = "Status",
        .subscription_creation_time = "SubscriptionCreationTime",
    };
};
