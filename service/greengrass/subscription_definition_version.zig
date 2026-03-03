const Subscription = @import("subscription.zig").Subscription;

/// Information about a subscription definition version.
pub const SubscriptionDefinitionVersion = struct {
    /// A list of subscriptions.
    subscriptions: ?[]const Subscription = null,

    pub const json_field_names = .{
        .subscriptions = "Subscriptions",
    };
};
