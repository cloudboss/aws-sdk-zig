const ConnectorProperty = @import("connector_property.zig").ConnectorProperty;
const ContentType = @import("content_type.zig").ContentType;
const HTTPMethod = @import("http_method.zig").HTTPMethod;

/// OAuth2 client credentials configuration that defines the properties needed
/// for the Client Credentials grant type flow.
pub const ClientCredentialsProperties = struct {
    /// The OAuth2 client identifier provided by the authorization server.
    client_id: ?ConnectorProperty,

    /// The OAuth2 client secret provided by the authorization server.
    client_secret: ?ConnectorProperty,

    /// The content type to use for token requests, such as
    /// application/x-www-form-urlencoded or application/json.
    content_type: ?ContentType,

    /// The HTTP method to use when making token requests, typically POST.
    request_method: ?HTTPMethod,

    /// The OAuth2 scope that defines the level of access requested for the client
    /// credentials flow.
    scope: ?ConnectorProperty,

    /// The token endpoint URL where the client will request access tokens using
    /// client credentials.
    token_url: ?ConnectorProperty,

    /// Additional parameters to include in token URL requests as key-value pairs.
    token_url_parameters: ?[]const ConnectorProperty,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .content_type = "ContentType",
        .request_method = "RequestMethod",
        .scope = "Scope",
        .token_url = "TokenUrl",
        .token_url_parameters = "TokenUrlParameters",
    };
};
