const NotificationContentType = @import("notification_content_type.zig").NotificationContentType;
const NotificationDeliveryType = @import("notification_delivery_type.zig").NotificationDeliveryType;
const NotificationRecipientType = @import("notification_recipient_type.zig").NotificationRecipientType;

/// Information about the send notification action.
pub const SendNotificationActionDefinition = struct {
    /// Notification content. Supports variable injection. For more information, see
    /// [JSONPath
    /// reference](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-variable-injection.html)
    /// in the *Amazon Connect Administrators Guide*.
    content: []const u8,

    /// Content type format.
    content_type: NotificationContentType,

    /// Notification delivery method.
    delivery_method: NotificationDeliveryType,

    /// Recipients to exclude from notification.
    exclusion: ?NotificationRecipientType,

    /// Notification recipient.
    recipient: NotificationRecipientType,

    /// The subject of the email if the delivery method is `EMAIL`. Supports
    /// variable injection. For more information, see
    /// [JSONPath
    /// reference](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-variable-injection.html)
    /// in the *Amazon Connect Administrators Guide*.
    subject: ?[]const u8,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
        .delivery_method = "DeliveryMethod",
        .exclusion = "Exclusion",
        .recipient = "Recipient",
        .subject = "Subject",
    };
};
