/// A comment that's posted by a user on a control. This includes the author's
/// name, the
/// comment text, and a timestamp.
pub const ControlComment = struct {
    /// The name of the user who authored the comment.
    author_name: ?[]const u8,

    /// The body text of a control comment.
    comment_body: ?[]const u8,

    /// The time when the comment was posted.
    posted_date: ?i64,

    pub const json_field_names = .{
        .author_name = "authorName",
        .comment_body = "commentBody",
        .posted_date = "postedDate",
    };
};
