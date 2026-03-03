const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;

/// An interest group, theme, or label within a list. Lists can have multiple
/// topics.
pub const Topic = struct {
    /// The default subscription status to be applied to a contact if the contact
    /// has not
    /// noted their preference for subscribing to a topic.
    default_subscription_status: SubscriptionStatus,

    /// A description of what the topic is about, which the contact will see.
    description: ?[]const u8 = null,

    /// The name of the topic the contact will see.
    display_name: []const u8,

    /// The name of the topic.
    topic_name: []const u8,

    pub const json_field_names = .{
        .default_subscription_status = "DefaultSubscriptionStatus",
        .description = "Description",
        .display_name = "DisplayName",
        .topic_name = "TopicName",
    };
};
