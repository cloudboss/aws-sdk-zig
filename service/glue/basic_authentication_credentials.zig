/// For supplying basic auth credentials when not providing a `SecretArn` value.
pub const BasicAuthenticationCredentials = struct {
    /// The password to connect to the data source.
    password: ?[]const u8 = null,

    /// The username to connect to the data source.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
