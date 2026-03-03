const UpdateConnectionOAuthClientRequestParameters = @import("update_connection_o_auth_client_request_parameters.zig").UpdateConnectionOAuthClientRequestParameters;
const ConnectionOAuthHttpMethod = @import("connection_o_auth_http_method.zig").ConnectionOAuthHttpMethod;
const ConnectionHttpParameters = @import("connection_http_parameters.zig").ConnectionHttpParameters;

/// Contains the OAuth request parameters to use for the connection.
pub const UpdateConnectionOAuthRequestParameters = struct {
    /// The URL to the authorization endpoint when OAuth is specified as the
    /// authorization
    /// type.
    authorization_endpoint: ?[]const u8 = null,

    /// A `UpdateConnectionOAuthClientRequestParameters` object that contains the
    /// client parameters to use for the connection when OAuth is specified as the
    /// authorization
    /// type.
    client_parameters: ?UpdateConnectionOAuthClientRequestParameters = null,

    /// The method used to connect to the HTTP endpoint.
    http_method: ?ConnectionOAuthHttpMethod = null,

    /// The additional HTTP parameters used for the OAuth authorization request.
    o_auth_http_parameters: ?ConnectionHttpParameters = null,

    pub const json_field_names = .{
        .authorization_endpoint = "AuthorizationEndpoint",
        .client_parameters = "ClientParameters",
        .http_method = "HttpMethod",
        .o_auth_http_parameters = "OAuthHttpParameters",
    };
};
