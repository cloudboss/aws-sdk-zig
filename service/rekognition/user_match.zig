const MatchedUser = @import("matched_user.zig").MatchedUser;

/// Provides UserID metadata along with the confidence in the match of this
/// UserID with the
/// input face.
pub const UserMatch = struct {
    /// Describes the UserID metadata.
    similarity: ?f32,

    /// Confidence in the match of this UserID with the input face.
    user: ?MatchedUser,

    pub const json_field_names = .{
        .similarity = "Similarity",
        .user = "User",
    };
};
