const CreateConnectionOAuthClientRequestParameters = @import("create_connection_o_auth_client_request_parameters.zig").CreateConnectionOAuthClientRequestParameters;
const ConnectionOAuthHttpMethod = @import("connection_o_auth_http_method.zig").ConnectionOAuthHttpMethod;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;

/// Contains the OAuth authorization parameters to use for the connection.
pub const CreateConnectionOAuthRequestParameters = struct {
    /// The URL to the authorization endpoint when OAuth is specified as the
    /// authorization
    /// type.
    authorization_endpoint: []const u8,

    /// A `CreateConnectionOAuthClientRequestParameters` object that contains the
    /// client parameters for OAuth authorization.
    client_parameters: CreateConnectionOAuthClientRequestParameters,

    /// The method to use for the authorization request.
    http_method: ConnectionOAuthHttpMethod,

    /// A `ConnectionHttpParameters` object that contains details about the
    /// additional
    /// parameters to use for the connection.
    o_auth_http_parameters: ?ConnectionHttpParameters,

    pub const json_field_names = .{
        .authorization_endpoint = "AuthorizationEndpoint",
        .client_parameters = "ClientParameters",
        .http_method = "HttpMethod",
        .o_auth_http_parameters = "OAuthHttpParameters",
    };
};
