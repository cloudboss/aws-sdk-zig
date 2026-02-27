const UsernamePassword = @import("username_password.zig").UsernamePassword;

/// The credentials that you can use to connect to cluster endpoints.
/// Credentials consist of
/// a username and a password.
pub const Credentials = union(enum) {
    /// The username and password that you use to connect to cluster endpoints.
    username_password: ?UsernamePassword,

    pub const json_field_names = .{
        .username_password = "UsernamePassword",
    };
};
