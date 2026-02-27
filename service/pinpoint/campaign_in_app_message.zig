const aws = @import("aws");

const InAppMessageContent = @import("in_app_message_content.zig").InAppMessageContent;
const Layout = @import("layout.zig").Layout;

/// In-app message configuration.
pub const CampaignInAppMessage = struct {
    /// The message body of the notification, the email body or the text message.
    body: ?[]const u8,

    /// In-app message content.
    content: ?[]const InAppMessageContent,

    /// Custom config to be sent to client.
    custom_config: ?[]const aws.map.StringMapEntry,

    /// In-app message layout.
    layout: ?Layout,

    pub const json_field_names = .{
        .body = "Body",
        .content = "Content",
        .custom_config = "CustomConfig",
        .layout = "Layout",
    };
};
