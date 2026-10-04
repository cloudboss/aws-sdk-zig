const WebNotificationContext = @import("web_notification_context.zig").WebNotificationContext;

/// Additional metadata related to the event trigger context
pub const ChannelContext = struct {
    web_notification_context: ?WebNotificationContext = null,

    pub const json_field_names = .{
        .web_notification_context = "webNotificationContext",
    };
};
