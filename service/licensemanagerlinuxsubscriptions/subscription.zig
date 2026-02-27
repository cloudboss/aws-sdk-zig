/// An object which details a discovered Linux subscription.
pub const Subscription = struct {
    /// The total amount of running instances using this subscription.
    instance_count: ?i64,

    /// The name of the subscription.
    name: ?[]const u8,

    /// The type of subscription. The type can be subscription-included with Amazon
    /// EC2, Bring Your Own
    /// Subscription model (BYOS), or from the Amazon Web Services Marketplace.
    /// Certain subscriptions may use licensing from the
    /// Amazon Web Services Marketplace as well as OS licensing from Amazon EC2 or
    /// BYOS.
    type: ?[]const u8,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .name = "Name",
        .type = "Type",
    };
};
