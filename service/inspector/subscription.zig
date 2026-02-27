const EventSubscription = @import("event_subscription.zig").EventSubscription;

/// This data type is used as a response element in the ListEventSubscriptions
/// action.
pub const Subscription = struct {
    /// The list of existing event subscriptions.
    event_subscriptions: []const EventSubscription,

    /// The ARN of the assessment template that is used during the event for which
    /// the SNS
    /// notification is sent.
    resource_arn: []const u8,

    /// The ARN of the Amazon Simple Notification Service (SNS) topic to which the
    /// SNS
    /// notifications are sent.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .event_subscriptions = "eventSubscriptions",
        .resource_arn = "resourceArn",
        .topic_arn = "topicArn",
    };
};
