const ContentType = @import("content_type.zig").ContentType;
const ConnectorProperty = @import("connector_property.zig").ConnectorProperty;
const HTTPMethod = @import("http_method.zig").HTTPMethod;

/// JWT bearer token configuration that defines the properties needed for the
/// JWT Bearer grant type flow.
pub const JWTBearerProperties = struct {
    /// The content type to use for JWT bearer token requests, such as
    /// application/x-www-form-urlencoded or application/json.
    content_type: ?ContentType = null,

    /// The JWT token to be used in the bearer token grant flow for authentication.
    jwt_token: ?ConnectorProperty = null,

    /// The HTTP method to use when making JWT bearer token requests, typically
    /// POST.
    request_method: ?HTTPMethod = null,

    /// The token endpoint URL where the JWT bearer token will be exchanged for an
    /// access token.
    token_url: ?ConnectorProperty = null,

    /// Additional parameters to include in token URL requests as key-value pairs.
    token_url_parameters: ?[]const ConnectorProperty = null,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .jwt_token = "JwtToken",
        .request_method = "RequestMethod",
        .token_url = "TokenUrl",
        .token_url_parameters = "TokenUrlParameters",
    };
};
