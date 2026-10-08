const UserType = @import("user_type.zig").UserType;

/// Reference to a user in the system
pub const UserReference = struct {
    /// The unique identifier for the user
    user_id: []const u8,

    /// The type of user
    user_type: UserType,

    pub const json_field_names = .{
        .user_id = "userId",
        .user_type = "userType",
    };
};
