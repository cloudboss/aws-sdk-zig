const UserType = @import("user_type.zig").UserType;

/// The principal for which the permission applies.
pub const PrincipalOutput = struct {
    /// The email address associated with the user.
    email: ?[]const u8,

    /// The unique identifier of the user.
    user_id: ?[]const u8,

    /// The type of the user.
    user_type: ?UserType,

    pub const json_field_names = .{
        .email = "email",
        .user_id = "userId",
        .user_type = "userType",
    };
};
