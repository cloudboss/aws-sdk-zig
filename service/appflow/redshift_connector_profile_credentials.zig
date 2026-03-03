/// The connector-specific profile credentials required when using Amazon
/// Redshift.
pub const RedshiftConnectorProfileCredentials = struct {
    /// The password that corresponds to the user name.
    password: ?[]const u8 = null,

    /// The name of the user.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .password = "password",
        .username = "username",
    };
};
