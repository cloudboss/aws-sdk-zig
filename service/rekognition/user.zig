const UserStatus = @import("user_status.zig").UserStatus;

/// Metadata of the user stored in a collection.
pub const User = struct {
    /// A provided ID for the User. Unique within the collection.
    user_id: ?[]const u8 = null,

    /// Communicates if the UserID has been updated with latest set of faces to be
    /// associated
    /// with the UserID.
    user_status: ?UserStatus = null,

    pub const json_field_names = .{
        .user_id = "UserId",
        .user_status = "UserStatus",
    };
};
