const ContentType = @import("content_type.zig").ContentType;

/// The message object that provides the message text and its
/// type.
pub const Message = struct {
    /// The text of the message.
    content: []const u8,

    /// The content type of the message string.
    content_type: ContentType,

    /// Identifies the message group that the message belongs to. When a group
    /// is assigned to a message, Amazon Lex returns one message from each group in
    /// the
    /// response.
    group_number: ?i32,

    pub const json_field_names = .{
        .content = "content",
        .content_type = "contentType",
        .group_number = "groupNumber",
    };
};
