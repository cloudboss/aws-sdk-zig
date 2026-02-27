const SubscriptionStatus = @import("subscription_status.zig").SubscriptionStatus;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;

/// Provides information about your Amazon Web Services Outposts subscriptions.
pub const Subscription = struct {
    /// The date your subscription starts.
    begin_date: ?i64,

    /// The date your subscription ends.
    end_date: ?i64,

    /// The amount you are billed each month in the subscription period.
    monthly_recurring_price: ?f64,

    /// The order ID for your subscription.
    order_ids: ?[]const []const u8,

    /// The ID of the subscription that appears on the Amazon Web Services Billing
    /// Center console.
    subscription_id: ?[]const u8,

    /// The status of subscription which can be one of the following:
    ///
    /// * **INACTIVE** - Subscription requests that are
    /// inactive.
    ///
    /// * **ACTIVE** - Subscription requests that are in progress
    /// and have an end date in the future.
    ///
    /// * **CANCELLED** - Subscription requests that are
    /// cancelled.
    subscription_status: ?SubscriptionStatus,

    /// The type of subscription which can be one of the following:
    ///
    /// * **ORIGINAL** - The first order on the Amazon Web Services Outposts.
    ///
    /// * **RENEWAL** - Renewal requests, both month to month and
    /// longer term.
    ///
    /// * **CAPACITY_INCREASE** - Capacity scaling orders.
    subscription_type: ?SubscriptionType,

    /// The amount billed when the subscription is created. This is a one-time
    /// charge.
    upfront_price: ?f64,

    pub const json_field_names = .{
        .begin_date = "BeginDate",
        .end_date = "EndDate",
        .monthly_recurring_price = "MonthlyRecurringPrice",
        .order_ids = "OrderIds",
        .subscription_id = "SubscriptionId",
        .subscription_status = "SubscriptionStatus",
        .subscription_type = "SubscriptionType",
        .upfront_price = "UpfrontPrice",
    };
};
