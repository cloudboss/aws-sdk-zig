/// A wrapper type for the attributes of an Amazon SNS subscription.
pub const AwsSnsTopicSubscription = struct {
    /// The subscription's endpoint (format depends on the protocol).
    endpoint: ?[]const u8,

    /// The subscription's protocol.
    protocol: ?[]const u8,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .protocol = "Protocol",
    };
};
