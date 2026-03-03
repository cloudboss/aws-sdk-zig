const aws = @import("aws");

/// Information about the raw email body content.
pub const InboundRawMessage = struct {
    /// The email message body.
    body: []const u8,

    /// Type of content, that is, `text/plain` or `text/html`.
    content_type: []const u8,

    /// Headers present in inbound email.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// The email subject.
    subject: []const u8,

    pub const json_field_names = .{
        .body = "Body",
        .content_type = "ContentType",
        .headers = "Headers",
        .subject = "Subject",
    };
};
