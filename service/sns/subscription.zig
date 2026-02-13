/// A wrapper type for the attributes of an Amazon SNS subscription.
pub const Subscription = struct {
    /// The subscription's endpoint (format depends on the protocol).
    endpoint: ?[]const u8,

    /// The subscription's owner.
    owner: ?[]const u8,

    /// The subscription's protocol.
    protocol: ?[]const u8,

    /// The subscription's ARN.
    subscription_arn: ?[]const u8,

    /// The ARN of the subscription's topic.
    topic_arn: ?[]const u8,
};
