/// Information about an action that returns a custom HTTP response.
pub const FixedResponseActionConfig = struct {
    /// The content type.
    ///
    /// Valid Values: text/plain | text/css | text/html | application/javascript |
    /// application/json
    content_type: ?[]const u8 = null,

    /// The message.
    message_body: ?[]const u8 = null,

    /// The HTTP response code (2XX, 4XX, or 5XX).
    status_code: []const u8,
};
