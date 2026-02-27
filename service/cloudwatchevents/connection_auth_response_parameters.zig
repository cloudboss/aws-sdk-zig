const ConnectionApiKeyAuthResponseParameters = @import("connection_api_key_auth_response_parameters.zig").ConnectionApiKeyAuthResponseParameters;
const ConnectionBasicAuthResponseParameters = @import("connection_basic_auth_response_parameters.zig").ConnectionBasicAuthResponseParameters;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;
const ConnectionOAuthResponseParameters = @import("connection_o_auth_response_parameters.zig").ConnectionOAuthResponseParameters;

/// Contains the authorization parameters to use for the connection.
pub const ConnectionAuthResponseParameters = struct {
    /// The API Key parameters to use for authorization.
    api_key_auth_parameters: ?ConnectionApiKeyAuthResponseParameters,

    /// The authorization parameters for Basic authorization.
    basic_auth_parameters: ?ConnectionBasicAuthResponseParameters,

    /// Additional parameters for the connection that are passed through with every
    /// invocation to
    /// the HTTP endpoint.
    invocation_http_parameters: ?ConnectionHttpParameters,

    /// The OAuth parameters to use for authorization.
    o_auth_parameters: ?ConnectionOAuthResponseParameters,

    pub const json_field_names = .{
        .api_key_auth_parameters = "ApiKeyAuthParameters",
        .basic_auth_parameters = "BasicAuthParameters",
        .invocation_http_parameters = "InvocationHttpParameters",
        .o_auth_parameters = "OAuthParameters",
    };
};
