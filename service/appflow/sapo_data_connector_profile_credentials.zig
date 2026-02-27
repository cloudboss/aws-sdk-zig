const BasicAuthCredentials = @import("basic_auth_credentials.zig").BasicAuthCredentials;
const OAuthCredentials = @import("o_auth_credentials.zig").OAuthCredentials;

/// The connector-specific profile credentials required when using SAPOData.
pub const SAPODataConnectorProfileCredentials = struct {
    /// The SAPOData basic authentication credentials.
    basic_auth_credentials: ?BasicAuthCredentials,

    /// The SAPOData OAuth type authentication credentials.
    o_auth_credentials: ?OAuthCredentials,

    pub const json_field_names = .{
        .basic_auth_credentials = "basicAuthCredentials",
        .o_auth_credentials = "oAuthCredentials",
    };
};
