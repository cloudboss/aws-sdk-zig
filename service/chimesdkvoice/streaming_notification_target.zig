const NotificationTarget = @import("notification_target.zig").NotificationTarget;

/// The target recipient for a streaming configuration notification.
pub const StreamingNotificationTarget = struct {
    /// The streaming notification target.
    notification_target: ?NotificationTarget = null,

    pub const json_field_names = .{
        .notification_target = "NotificationTarget",
    };
};
