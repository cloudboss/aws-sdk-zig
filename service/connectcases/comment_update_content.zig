const CommentBodyTextType = @import("comment_body_text_type.zig").CommentBodyTextType;

/// Represents the updated content of a `Comment` related item.
pub const CommentUpdateContent = struct {
    /// Updated text in the body of a `Comment` on a case.
    body: []const u8,

    /// Type of the text in the box of a `Comment` on a case.
    content_type: CommentBodyTextType,

    pub const json_field_names = .{
        .body = "body",
        .content_type = "contentType",
    };
};
