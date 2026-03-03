/// Contains the Basic authorization parameters for the connection.
pub const UpdateConnectionBasicAuthRequestParameters = struct {
    /// The password associated with the user name to use for Basic authorization.
    password: ?[]const u8 = null,

    /// The user name to use for Basic authorization.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
