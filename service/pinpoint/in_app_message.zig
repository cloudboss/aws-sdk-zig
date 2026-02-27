const aws = @import("aws");

const InAppMessageContent = @import("in_app_message_content.zig").InAppMessageContent;
const Layout = @import("layout.zig").Layout;

/// Provides all fields required for building an in-app message.
pub const InAppMessage = struct {
    /// In-app message content.
    content: ?[]const InAppMessageContent,

    /// Custom config to be sent to SDK.
    custom_config: ?[]const aws.map.StringMapEntry,

    /// The layout of the message.
    layout: ?Layout,

    pub const json_field_names = .{
        .content = "Content",
        .custom_config = "CustomConfig",
        .layout = "Layout",
    };
};
