const InAppMessageBodyConfig = @import("in_app_message_body_config.zig").InAppMessageBodyConfig;
const InAppMessageHeaderConfig = @import("in_app_message_header_config.zig").InAppMessageHeaderConfig;
const InAppMessageButton = @import("in_app_message_button.zig").InAppMessageButton;

/// The configuration for the message content.
pub const InAppMessageContent = struct {
    /// The background color for the message.
    background_color: ?[]const u8 = null,

    /// The configuration for the message body.
    body_config: ?InAppMessageBodyConfig = null,

    /// The configuration for the message header.
    header_config: ?InAppMessageHeaderConfig = null,

    /// The image url for the background of message.
    image_url: ?[]const u8 = null,

    /// The first button inside the message.
    primary_btn: ?InAppMessageButton = null,

    /// The second button inside message.
    secondary_btn: ?InAppMessageButton = null,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .body_config = "BodyConfig",
        .header_config = "HeaderConfig",
        .image_url = "ImageUrl",
        .primary_btn = "PrimaryBtn",
        .secondary_btn = "SecondaryBtn",
    };
};
