/// Details about an Amazon RDS event notification subscription. The
/// subscription allows Amazon RDS to post events to an SNS topic.
pub const AwsRdsEventSubscriptionDetails = struct {
    /// The identifier of the event notification subscription.
    customer_aws_id: ?[]const u8 = null,

    /// The identifier of the account that is associated with the event notification
    /// subscription.
    cust_subscription_id: ?[]const u8 = null,

    /// Whether the event notification subscription is enabled.
    enabled: ?bool = null,

    /// The list of event categories for the event notification subscription.
    event_categories_list: ?[]const []const u8 = null,

    /// The ARN of the event notification subscription.
    event_subscription_arn: ?[]const u8 = null,

    /// The ARN of the SNS topic to post the event notifications to.
    sns_topic_arn: ?[]const u8 = null,

    /// A list of source identifiers for the event notification subscription.
    source_ids_list: ?[]const []const u8 = null,

    /// The source type for the event notification subscription.
    source_type: ?[]const u8 = null,

    /// The status of the event notification subscription.
    ///
    /// Valid values: `creating` | `modifying` | `deleting` | `active` |
    /// `no-permission` | `topic-not-exist`
    status: ?[]const u8 = null,

    /// The datetime when the event notification subscription was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    subscription_creation_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_aws_id = "CustomerAwsId",
        .cust_subscription_id = "CustSubscriptionId",
        .enabled = "Enabled",
        .event_categories_list = "EventCategoriesList",
        .event_subscription_arn = "EventSubscriptionArn",
        .sns_topic_arn = "SnsTopicArn",
        .source_ids_list = "SourceIdsList",
        .source_type = "SourceType",
        .status = "Status",
        .subscription_creation_time = "SubscriptionCreationTime",
    };
};
