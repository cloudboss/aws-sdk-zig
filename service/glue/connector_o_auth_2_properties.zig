const ConnectorAuthorizationCodeProperties = @import("connector_authorization_code_properties.zig").ConnectorAuthorizationCodeProperties;
const ClientCredentialsProperties = @import("client_credentials_properties.zig").ClientCredentialsProperties;
const JWTBearerProperties = @import("jwt_bearer_properties.zig").JWTBearerProperties;
const ConnectorOAuth2GrantType = @import("connector_o_auth_2_grant_type.zig").ConnectorOAuth2GrantType;

/// OAuth2 configuration container that defines the authentication properties
/// and flow-specific configurations for OAuth2-based connections.
pub const ConnectorOAuth2Properties = struct {
    /// Configuration properties specific to the OAuth2 Authorization Code grant
    /// type flow.
    authorization_code_properties: ?ConnectorAuthorizationCodeProperties = null,

    /// Configuration properties specific to the OAuth2 Client Credentials grant
    /// type flow.
    client_credentials_properties: ?ClientCredentialsProperties = null,

    /// Configuration properties specific to the OAuth2 JWT Bearer grant type flow.
    jwt_bearer_properties: ?JWTBearerProperties = null,

    /// The OAuth2 grant type to use for authentication, such as CLIENT_CREDENTIALS,
    /// JWT_BEARER, or AUTHORIZATION_CODE.
    o_auth_2_grant_type: ConnectorOAuth2GrantType,

    pub const json_field_names = .{
        .authorization_code_properties = "AuthorizationCodeProperties",
        .client_credentials_properties = "ClientCredentialsProperties",
        .jwt_bearer_properties = "JWTBearerProperties",
        .o_auth_2_grant_type = "OAuth2GrantType",
    };
};
