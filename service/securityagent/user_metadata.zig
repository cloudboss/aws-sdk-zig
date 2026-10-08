/// Contains metadata about a user member, including the username and email
/// address.
pub const UserMetadata = struct {
    /// The email address of the user.
    email: []const u8,

    /// The username of the user.
    username: []const u8,

    pub const json_field_names = .{
        .email = "email",
        .username = "username",
    };
};
