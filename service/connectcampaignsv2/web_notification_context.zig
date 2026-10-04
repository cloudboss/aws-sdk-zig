/// Context metadata for the web notification type channel
pub const WebNotificationContext = struct {
    browser_id: ?[]const u8 = null,

    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .browser_id = "browserId",
        .session_id = "sessionId",
    };
};
