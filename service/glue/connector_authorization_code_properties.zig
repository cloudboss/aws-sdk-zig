const ConnectorProperty = @import("connector_property.zig").ConnectorProperty;
const ContentType = @import("content_type.zig").ContentType;
const HTTPMethod = @import("http_method.zig").HTTPMethod;

/// OAuth2 authorization code configuration that defines the properties needed
/// for the Authorization Code grant type flow.
pub const ConnectorAuthorizationCodeProperties = struct {
    /// The authorization code received from the authorization server after user
    /// consent.
    authorization_code: ?ConnectorProperty,

    /// The authorization endpoint URL where users will be redirected to grant
    /// authorization.
    authorization_code_url: ?ConnectorProperty,

    /// The OAuth2 client identifier provided by the authorization server.
    client_id: ?ConnectorProperty,

    /// The OAuth2 client secret provided by the authorization server.
    client_secret: ?ConnectorProperty,

    /// The content type to use for token exchange requests, such as
    /// application/x-www-form-urlencoded or application/json.
    content_type: ?ContentType,

    /// The OAuth2 prompt parameter that controls the authorization server's
    /// behavior during user authentication.
    prompt: ?ConnectorProperty,

    /// The redirect URI that must match the URI registered with the authorization
    /// server.
    redirect_uri: ?ConnectorProperty,

    /// The HTTP method to use when making token exchange requests, typically POST.
    request_method: ?HTTPMethod,

    /// The OAuth2 scope that defines the level of access requested for the
    /// authorization code flow.
    scope: ?ConnectorProperty,

    /// The token endpoint URL where the authorization code will be exchanged for an
    /// access token.
    token_url: ?ConnectorProperty,

    /// Additional parameters to include in token URL requests as key-value pairs.
    token_url_parameters: ?[]const ConnectorProperty,

    pub const json_field_names = .{
        .authorization_code = "AuthorizationCode",
        .authorization_code_url = "AuthorizationCodeUrl",
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .content_type = "ContentType",
        .prompt = "Prompt",
        .redirect_uri = "RedirectUri",
        .request_method = "RequestMethod",
        .scope = "Scope",
        .token_url = "TokenUrl",
        .token_url_parameters = "TokenUrlParameters",
    };
};
