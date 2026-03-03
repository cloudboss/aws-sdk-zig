const SubscriptionDetails = @import("subscription_details.zig").SubscriptionDetails;
const SubscriptionPrincipal = @import("subscription_principal.zig").SubscriptionPrincipal;

/// Information about an Amazon Q Business subscription.
///
/// Subscriptions are used to provide access for an IAM Identity Center user or
/// a group to an Amazon Q Business application.
///
/// Amazon Q Business offers two subscription tiers: `Q_LITE` and `Q_BUSINESS`.
/// Subscription tier determines feature access for the user. For more
/// information on subscriptions and pricing tiers, see [Amazon Q Business
/// pricing](https://aws.amazon.com/q/business/pricing/).
pub const Subscription = struct {
    /// The type of your current Amazon Q Business subscription.
    current_subscription: ?SubscriptionDetails = null,

    /// The type of the Amazon Q Business subscription for the next month.
    next_subscription: ?SubscriptionDetails = null,

    /// The IAM Identity Center `UserId` or `GroupId` of a user or group in the IAM
    /// Identity Center instance connected to the Amazon Q Business application.
    principal: ?SubscriptionPrincipal = null,

    /// The Amazon Resource Name (ARN) of the Amazon Q Business subscription that
    /// was updated.
    subscription_arn: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business subscription to be updated.
    subscription_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_subscription = "currentSubscription",
        .next_subscription = "nextSubscription",
        .principal = "principal",
        .subscription_arn = "subscriptionArn",
        .subscription_id = "subscriptionId",
    };
};
