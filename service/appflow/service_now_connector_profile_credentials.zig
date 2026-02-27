const OAuth2Credentials = @import("o_auth_2_credentials.zig").OAuth2Credentials;

/// The connector-specific profile credentials required when using ServiceNow.
pub const ServiceNowConnectorProfileCredentials = struct {
    /// The OAuth 2.0 credentials required to authenticate the user.
    o_auth_2_credentials: ?OAuth2Credentials,

    /// The password that corresponds to the user name.
    password: ?[]const u8,

    /// The name of the user.
    username: ?[]const u8,

    pub const json_field_names = .{
        .o_auth_2_credentials = "oAuth2Credentials",
        .password = "password",
        .username = "username",
    };
};
