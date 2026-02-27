/// The username and password of a connection.
pub const UsernamePassword = struct {
    /// The password of a connection.
    password: []const u8,

    /// The username of a connection.
    username: []const u8,

    pub const json_field_names = .{
        .password = "password",
        .username = "username",
    };
};
