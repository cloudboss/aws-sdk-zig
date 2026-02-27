const CommentBodyTextType = @import("comment_body_text_type.zig").CommentBodyTextType;

/// Represents the content of a `Comment` to be returned to agents.
pub const CommentContent = struct {
    /// Text in the body of a `Comment` on a case.
    body: []const u8,

    /// Type of the text in the box of a `Comment` on a case.
    content_type: CommentBodyTextType,

    pub const json_field_names = .{
        .body = "body",
        .content_type = "contentType",
    };
};
