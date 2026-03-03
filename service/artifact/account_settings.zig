const NotificationSubscriptionStatus = @import("notification_subscription_status.zig").NotificationSubscriptionStatus;

/// Account settings for the customer.
pub const AccountSettings = struct {
    /// Notification subscription status of the customer.
    notification_subscription_status: ?NotificationSubscriptionStatus = null,

    pub const json_field_names = .{
        .notification_subscription_status = "notificationSubscriptionStatus",
    };
};
