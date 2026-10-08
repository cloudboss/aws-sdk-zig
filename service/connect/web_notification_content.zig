const ContentAttributes = @import("content_attributes.zig").ContentAttributes;
const NotificationType = @import("notification_type.zig").NotificationType;

/// The content of an outbound web notification, including the notification
/// type, the view to render, and any
/// optional attributes used to populate the view.
pub const WebNotificationContent = struct {
    /// Optional attributes used to populate the notification content, such as
    /// recommender configuration for
    /// personalized content.
    attributes: ?ContentAttributes = null,

    /// The type of web notification to send.
    type: NotificationType,

    /// The Amazon Resource Name (ARN) of the view to render for the notification.
    view_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .type = "Type",
        .view_arn = "ViewArn",
    };
};
