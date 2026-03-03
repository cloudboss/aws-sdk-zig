const BasicAuthenticationCredentials = @import("basic_authentication_credentials.zig").BasicAuthenticationCredentials;

/// The authentication configuration patch of a connection.
pub const AuthenticationConfigurationPatch = struct {
    /// The basic authentication credentials of a connection.
    basic_authentication_credentials: ?BasicAuthenticationCredentials = null,

    /// The secret ARN of a connection.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .basic_authentication_credentials = "basicAuthenticationCredentials",
        .secret_arn = "secretArn",
    };
};
