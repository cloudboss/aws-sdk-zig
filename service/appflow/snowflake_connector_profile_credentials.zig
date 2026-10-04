/// The connector-specific profile credentials required when using Snowflake.
pub const SnowflakeConnectorProfileCredentials = struct {
    /// The password that corresponds to the user name.
    password: ?[]const u8 = null,

    /// The RSA private key used for key pair authentication with Snowflake. Provide
    /// this
    /// instead of a password when your Snowflake account uses key pair
    /// authentication.
    private_key: ?[]const u8 = null,

    /// The name of the user.
    username: []const u8,

    pub const json_field_names = .{
        .password = "password",
        .private_key = "privateKey",
        .username = "username",
    };
};
