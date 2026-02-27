/// The basic authentication credentials of a connection.
pub const BasicAuthenticationCredentials = struct {
    /// The password for a connection.
    password: ?[]const u8,

    /// The user name for the connecion.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .password = "password",
        .user_name = "userName",
    };
};
