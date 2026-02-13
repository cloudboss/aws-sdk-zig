const NotificationEvent = @import("notification_event.zig").NotificationEvent;
const NotificationType = @import("notification_type.zig").NotificationType;

/// Configurations for sending notifications.
pub const NotificationConfig = struct {
    /// An Amazon Resource Name (ARN) for an Amazon Simple Notification Service
    /// (Amazon SNS) topic. Run
    /// Command pushes notifications about command status changes to this topic.
    notification_arn: ?[]const u8,

    /// The different events for which you can receive notifications. To learn more
    /// about these
    /// events, see [Monitoring Systems Manager status
    /// changes using Amazon SNS
    /// notifications](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitoring-sns-notifications.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    notification_events: ?[]const NotificationEvent,

    /// The type of notification.
    ///
    /// * `Command`: Receive notification when the status of a command changes.
    ///
    /// * `Invocation`: For commands sent to multiple managed nodes, receive
    ///   notification
    /// on a per-node basis when the status of a command changes.
    notification_type: ?NotificationType,

    pub const json_field_names = .{
        .notification_arn = "NotificationArn",
        .notification_events = "NotificationEvents",
        .notification_type = "NotificationType",
    };
};
