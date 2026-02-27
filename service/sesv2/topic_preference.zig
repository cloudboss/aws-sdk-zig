const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;

/// The contact's preference for being opted-in to or opted-out of a topic.
pub const TopicPreference = struct {
    /// The contact's subscription status to a topic which is either `OPT_IN` or
    /// `OPT_OUT`.
    subscription_status: SubscriptionStatus,

    /// The name of the topic.
    topic_name: []const u8,

    pub const json_field_names = .{
        .subscription_status = "SubscriptionStatus",
        .topic_name = "TopicName",
    };
};
