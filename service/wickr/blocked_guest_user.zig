/// Represents a guest user who has been blocked from accessing a Wickr network.
pub const BlockedGuestUser = struct {
    /// The username of the administrator who blocked this guest user.
    admin: []const u8,

    /// The timestamp when the guest user was blocked or last modified.
    modified: []const u8,

    /// The username of the blocked guest user.
    username: []const u8,

    /// The unique username hash identifier for the blocked guest user.
    username_hash: []const u8,

    pub const json_field_names = .{
        .admin = "admin",
        .modified = "modified",
        .username = "username",
        .username_hash = "usernameHash",
    };
};
