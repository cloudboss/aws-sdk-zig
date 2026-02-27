const ConnectionOAuthClientResponseParameters = @import("connection_o_auth_client_response_parameters.zig").ConnectionOAuthClientResponseParameters;
const ConnectionOAuthHttpMethod = @import("connection_o_auth_http_method.zig").ConnectionOAuthHttpMethod;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;

/// The response parameters when OAuth is specified as the authorization type.
pub const ConnectionOAuthResponseParameters = struct {
    /// The URL to the HTTP endpoint that authorized the request.
    authorization_endpoint: ?[]const u8,

    /// Details about the client parameters returned when OAuth is specified as the
    /// authorization type.
    client_parameters: ?ConnectionOAuthClientResponseParameters,

    /// The method used to connect to the HTTP endpoint.
    http_method: ?ConnectionOAuthHttpMethod,

    /// The additional HTTP parameters used for the OAuth authorization request.
    o_auth_http_parameters: ?ConnectionHttpParameters,

    pub const json_field_names = .{
        .authorization_endpoint = "AuthorizationEndpoint",
        .client_parameters = "ClientParameters",
        .http_method = "HttpMethod",
        .o_auth_http_parameters = "OAuthHttpParameters",
    };
};
