/// The basic authentication credentials of a connection.
pub const BasicAuthenticationCredentials = struct {
    /// The password for a connection.
    password: ?[]const u8 = null,

    /// The user name for the connecion.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .password = "password",
        .user_name = "userName",
    };
};
