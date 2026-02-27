/// Information about the raw email body content.
pub const OutboundRawMessage = struct {
    /// The email message body.
    body: []const u8,

    /// Type of content, that is, `text/plain` or `text/html`.
    content_type: []const u8,

    /// The email subject.
    subject: []const u8,

    pub const json_field_names = .{
        .body = "Body",
        .content_type = "ContentType",
        .subject = "Subject",
    };
};
