/// The connector-specific profile credentials required when using Veeva.
pub const VeevaConnectorProfileCredentials = struct {
    /// The password that corresponds to the user name.
    password: []const u8,

    /// The name of the user.
    username: []const u8,

    pub const json_field_names = .{
        .password = "password",
        .username = "username",
    };
};
