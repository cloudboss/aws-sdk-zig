pub const SnsNotificationPayloadType = enum {
    headers,
    content,

    pub const json_field_names = .{
        .headers = "HEADERS",
        .content = "CONTENT",
    };
};
