const SubscriptionType = @import("subscription_type.zig").SubscriptionType;

/// The subscriber to a budget notification. The subscriber consists of a
/// subscription
/// type and either an Amazon SNS topic or an email address.
///
/// For example, an email subscriber has the following parameters:
///
/// * A `subscriptionType` of `EMAIL`
///
/// * An `address` of `example@example.com`
pub const Subscriber = struct {
    /// The address that Amazon Web Services sends budget notifications to, either
    /// an SNS topic
    /// or an email.
    ///
    /// When you create a subscriber, the value of `Address` can't contain line
    /// breaks.
    address: []const u8,

    /// The type of notification that Amazon Web Services sends to a subscriber.
    subscription_type: SubscriptionType,

    pub const json_field_names = .{
        .address = "Address",
        .subscription_type = "SubscriptionType",
    };
};
