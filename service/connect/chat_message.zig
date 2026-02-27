/// A chat message.
pub const ChatMessage = struct {
    /// The content of the chat message.
    ///
    /// * For `text/plain` and `text/markdown`, the Length Constraints are Minimum
    ///   of 1, Maximum
    /// of 1024.
    ///
    /// * For `application/json`, the Length Constraints are Minimum of 1, Maximum
    ///   of 12000.
    ///
    /// * For `application/vnd.amazonaws.connect.message.interactive.response`, the
    ///   Length Constraints are
    /// Minimum of 1, Maximum of 12288.
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
