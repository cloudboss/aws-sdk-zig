const Notification = @import("notification.zig").Notification;
const Subscriber = @import("subscriber.zig").Subscriber;

/// A notification with subscribers. A notification can have one SNS subscriber
/// and up to
/// 10 email subscribers, for a total of 11 subscribers.
pub const NotificationWithSubscribers = struct {
    /// The notification that's associated with a budget.
    notification: Notification,

    /// A list of subscribers who are subscribed to this notification.
    subscribers: []const Subscriber,

    pub const json_field_names = .{
        .notification = "Notification",
        .subscribers = "Subscribers",
    };
};
