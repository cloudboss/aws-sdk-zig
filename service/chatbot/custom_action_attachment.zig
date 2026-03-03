const aws = @import("aws");

const CustomActionAttachmentCriteria = @import("custom_action_attachment_criteria.zig").CustomActionAttachmentCriteria;

/// Defines when a custom action button should be attached to a notification.
pub const CustomActionAttachment = struct {
    /// The text of the button that appears on the notification.
    button_text: ?[]const u8 = null,

    /// The criteria for when a button should be shown based on values in the
    /// notification.
    criteria: ?[]const CustomActionAttachmentCriteria = null,

    /// The type of notification that the custom action should be attached to.
    notification_type: ?[]const u8 = null,

    /// The variables to extract from the notification.
    variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .button_text = "ButtonText",
        .criteria = "Criteria",
        .notification_type = "NotificationType",
        .variables = "Variables",
    };
};
