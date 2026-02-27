const User = @import("user.zig").User;
const CommentStatusType = @import("comment_status_type.zig").CommentStatusType;
const CommentVisibilityType = @import("comment_visibility_type.zig").CommentVisibilityType;

/// Describes a comment.
pub const Comment = struct {
    /// The ID of the comment.
    comment_id: []const u8,

    /// The details of the user who made the comment.
    contributor: ?User,

    /// The time that the comment was created.
    created_timestamp: ?i64,

    /// The ID of the parent comment.
    parent_id: ?[]const u8,

    /// If the comment is a reply to another user's comment, this field contains the
    /// user
    /// ID of the user being replied to.
    recipient_id: ?[]const u8,

    /// The status of the comment.
    status: ?CommentStatusType,

    /// The text of the comment.
    text: ?[]const u8,

    /// The ID of the root comment in the thread.
    thread_id: ?[]const u8,

    /// The visibility of the comment. Options are either PRIVATE, where the comment
    /// is
    /// visible only to the comment author and document owner and co-owners, or
    /// PUBLIC, where
    /// the comment is visible to document owners, co-owners, and contributors.
    visibility: ?CommentVisibilityType,

    pub const json_field_names = .{
        .comment_id = "CommentId",
        .contributor = "Contributor",
        .created_timestamp = "CreatedTimestamp",
        .parent_id = "ParentId",
        .recipient_id = "RecipientId",
        .status = "Status",
        .text = "Text",
        .thread_id = "ThreadId",
        .visibility = "Visibility",
    };
};
