/// Contains the Basic authorization parameters to use for the connection.
pub const CreateConnectionBasicAuthRequestParameters = struct {
    /// The password associated with the user name to use for Basic authorization.
    password: []const u8,

    /// The user name to use for Basic authorization.
    username: []const u8,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
