const ConnectionNotificationState = @import("connection_notification_state.zig").ConnectionNotificationState;
const ConnectionNotificationType = @import("connection_notification_type.zig").ConnectionNotificationType;

/// Describes a connection notification for a VPC endpoint or VPC endpoint
/// service.
pub const ConnectionNotification = struct {
    /// The events for the notification. Valid values are `Accept`,
    /// `Connect`, `Delete`, and `Reject`.
    connection_events: ?[]const []const u8 = null,

    /// The ARN of the SNS topic for the notification.
    connection_notification_arn: ?[]const u8 = null,

    /// The ID of the notification.
    connection_notification_id: ?[]const u8 = null,

    /// The state of the notification.
    connection_notification_state: ?ConnectionNotificationState = null,

    /// The type of notification.
    connection_notification_type: ?ConnectionNotificationType = null,

    /// The ID of the endpoint service.
    service_id: ?[]const u8 = null,

    /// The Region for the endpoint service.
    service_region: ?[]const u8 = null,

    /// The ID of the VPC endpoint.
    vpc_endpoint_id: ?[]const u8 = null,
};
