/// A chat message.
pub const ChatMessage = struct {
    /// The content of the chat message. Maximum of 16,384 bytes for all content
    /// types
    /// (`text/plain`, `text/markdown`, `application/json`, and
    /// `application/vnd.amazonaws.connect.message.interactive.response`).
    ///
    /// Some messaging channels enforce lower limits. For channel-specific message
    /// size limits, see [Chat message size limits
    /// by
    /// channel](https://docs.aws.amazon.com/connect/latest/adminguide/feature-limits.html#chat-message-size-limits) in the *Amazon Connect Customer Administrator Guide*.
    content: []const u8,

    /// The type of the content. Supported types are `text/plain`, `text/markdown`,
    /// `application/json`, and
    /// `application/vnd.amazonaws.connect.message.interactive.response`.
    content_type: []const u8,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
    };
};
