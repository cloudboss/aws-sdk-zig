const aws = @import("aws");

const NotificationRecipientType = @import("notification_recipient_type.zig").NotificationRecipientType;
const ConfigurableNotificationPriority = @import("configurable_notification_priority.zig").ConfigurableNotificationPriority;

/// Information about the send in-app notification action.
pub const SendInAppNotificationActionDefinition = struct {
    /// Notification content. Supports variable injection. For more information, see
    /// [JSONPath
    /// reference](https://docs.aws.amazon.com/connect/latest/adminguide/contact-lens-variable-injection.html)
    /// in the *Connect Customer Administrators Guide*.
    content: []const aws.map.StringMapEntry,

    /// Recipients to exclude from notification.
    exclusion: ?NotificationRecipientType = null,

    /// Notification priority.
    priority: ?ConfigurableNotificationPriority = null,

    /// Notification recipient.
    recipient: NotificationRecipientType,

    pub const json_field_names = .{
        .content = "Content",
        .exclusion = "Exclusion",
        .priority = "Priority",
        .recipient = "Recipient",
    };
};
