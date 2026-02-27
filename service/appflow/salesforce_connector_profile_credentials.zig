const OAuth2GrantType = @import("o_auth_2_grant_type.zig").OAuth2GrantType;
const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The connector-specific profile credentials required when using Salesforce.
pub const SalesforceConnectorProfileCredentials = struct {
    /// The credentials used to access protected Salesforce resources.
    access_token: ?[]const u8,

    /// The secret manager ARN, which contains the client ID and client secret of
    /// the connected
    /// app.
    client_credentials_arn: ?[]const u8,

    /// A JSON web token (JWT) that authorizes Amazon AppFlow to access your
    /// Salesforce
    /// records.
    jwt_token: ?[]const u8,

    /// Specifies the OAuth 2.0 grant type that Amazon AppFlow uses when it requests
    /// an
    /// access token from Salesforce. Amazon AppFlow requires an access token each
    /// time it
    /// attempts to access your Salesforce records.
    ///
    /// You can specify one of the following values:
    ///
    /// **AUTHORIZATION_CODE**
    ///
    /// Amazon AppFlow passes an authorization code when it requests the access
    /// token
    /// from Salesforce. Amazon AppFlow receives the authorization code from
    /// Salesforce
    /// after you log in to your Salesforce account and authorize Amazon AppFlow to
    /// access
    /// your records.
    ///
    /// **JWT_BEARER**
    ///
    /// Amazon AppFlow passes a JSON web token (JWT) when it requests the access
    /// token
    /// from Salesforce. You provide the JWT to Amazon AppFlow when you define the
    /// connection to your Salesforce account. When you use this grant type, you
    /// don't need to
    /// log in to your Salesforce account to authorize Amazon AppFlow to access your
    /// records.
    ///
    /// The CLIENT_CREDENTIALS value is not supported for Salesforce.
    o_auth_2_grant_type: ?OAuth2GrantType,

    /// The OAuth requirement needed to request security tokens from the connector
    /// endpoint.
    o_auth_request: ?ConnectorOAuthRequest,

    /// The credentials used to acquire new access tokens.
    refresh_token: ?[]const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .client_credentials_arn = "clientCredentialsArn",
        .jwt_token = "jwtToken",
        .o_auth_2_grant_type = "oAuth2GrantType",
        .o_auth_request = "oAuthRequest",
        .refresh_token = "refreshToken",
    };
};
