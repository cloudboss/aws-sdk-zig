const UsernamePassword = @import("username_password.zig").UsernamePassword;

/// Amazon Redshift credentials of a connection.
pub const RedshiftCredentials = union(enum) {
    /// The secret ARN of the Amazon Redshift credentials of a connection.
    secret_arn: ?[]const u8,
    /// The username and password of the Amazon Redshift credentials of a
    /// connection.
    username_password: ?UsernamePassword,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
        .username_password = "usernamePassword",
    };
};
