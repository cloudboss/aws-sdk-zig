const SubscriptionType = @import("subscription_type.zig").SubscriptionType;

/// The details of an Amazon Q Business subscription.
pub const SubscriptionDetails = struct {
    /// The type of an Amazon Q Business subscription.
    @"type": ?SubscriptionType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
