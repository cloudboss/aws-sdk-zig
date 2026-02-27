const CommentStatusType = @import("comment_status_type.zig").CommentStatusType;
const User = @import("user.zig").User;

/// Describes the metadata of a comment.
pub const CommentMetadata = struct {
    /// The ID of the comment.
    comment_id: ?[]const u8,

    /// The status of the comment.
    comment_status: ?CommentStatusType,

    /// The user who made the comment.
    contributor: ?User,

    /// The ID of the user who made the comment.
    contributor_id: ?[]const u8,

    /// The timestamp that the comment was created.
    created_timestamp: ?i64,

    /// The ID of the user being replied to.
    recipient_id: ?[]const u8,

    pub const json_field_names = .{
        .comment_id = "CommentId",
        .comment_status = "CommentStatus",
        .contributor = "Contributor",
        .contributor_id = "ContributorId",
        .created_timestamp = "CreatedTimestamp",
        .recipient_id = "RecipientId",
    };
};
