/// The basic auth credentials required for basic authentication.
pub const BasicAuthCredentials = struct {
    /// The password to use to connect to a resource.
    password: []const u8,

    /// The username to use to connect to a resource.
    username: []const u8,

    pub const json_field_names = .{
        .password = "password",
        .username = "username",
    };
};
