pub const SnsNotificationEncoding = enum {
    utf_8,
    base64,

    pub const json_field_names = .{
        .utf_8 = "UTF_8",
        .base64 = "BASE64",
    };
};
