/// The username and password that you use to connect to cluster endpoints.
pub const UsernamePassword = struct {
    /// The password associated with the temporary credentials that you use to
    /// connect to
    /// cluster endpoints.
    password: ?[]const u8 = null,

    /// The username associated with the temporary credentials that you use to
    /// connect to
    /// cluster endpoints.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
