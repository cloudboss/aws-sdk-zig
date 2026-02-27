const SubscriptionProtocolType = @import("subscription_protocol_type.zig").SubscriptionProtocolType;

/// Describes a subscription.
pub const Subscription = struct {
    /// The endpoint of the subscription.
    end_point: ?[]const u8,

    /// The protocol of the subscription.
    protocol: ?SubscriptionProtocolType,

    /// The ID of the subscription.
    subscription_id: ?[]const u8,

    pub const json_field_names = .{
        .end_point = "EndPoint",
        .protocol = "Protocol",
        .subscription_id = "SubscriptionId",
    };
};
