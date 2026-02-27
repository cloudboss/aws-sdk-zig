const UserStatus = @import("user_status.zig").UserStatus;

/// Contains metadata for a UserID matched with a given face.
pub const MatchedUser = struct {
    /// A provided ID for the UserID. Unique within the collection.
    user_id: ?[]const u8,

    /// The status of the user matched to a provided FaceID.
    user_status: ?UserStatus,

    pub const json_field_names = .{
        .user_id = "UserId",
        .user_status = "UserStatus",
    };
};
