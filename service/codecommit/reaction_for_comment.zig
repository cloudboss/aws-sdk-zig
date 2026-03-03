const ReactionValueFormats = @import("reaction_value_formats.zig").ReactionValueFormats;

/// Information about the reaction values provided by users on a comment.
pub const ReactionForComment = struct {
    /// The reaction for a specified comment.
    reaction: ?ReactionValueFormats = null,

    /// A numerical count of users who reacted with the specified emoji whose
    /// identities have been subsequently deleted
    /// from IAM. While these IAM users or roles no longer exist, the reactions
    /// might still appear in total reaction counts.
    reactions_from_deleted_users_count: ?i32 = null,

    /// The Amazon Resource Names (ARNs) of users who have provided reactions to the
    /// comment.
    reaction_users: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .reaction = "reaction",
        .reactions_from_deleted_users_count = "reactionsFromDeletedUsersCount",
        .reaction_users = "reactionUsers",
    };
};
