/// The authentication settings for accessing provisioned data models in your
/// Amplify project.
pub const BackendAPIAppSyncAuthSettings = struct {
    /// The Amazon Cognito user pool ID, if Amazon Cognito was used as an
    /// authentication setting to access your data models.
    cognito_user_pool_id: ?[]const u8 = null,

    /// The API key description for API_KEY, if it was used as an authentication
    /// mechanism to access your data models.
    description: ?[]const u8 = null,

    /// The API key expiration time for API_KEY, if it was used as an authentication
    /// mechanism to access your data models.
    expiration_time: ?f64 = null,

    /// The expiry time for the OpenID authentication mechanism.
    open_id_auth_ttl: ?[]const u8 = null,

    /// The clientID for openID, if openID was used as an authentication setting to
    /// access your data models.
    open_id_client_id: ?[]const u8 = null,

    /// The expiry time for the OpenID authentication mechanism.
    open_id_iat_ttl: ?[]const u8 = null,

    /// The openID issuer URL, if openID was used as an authentication setting to
    /// access your data models.
    open_id_issue_url: ?[]const u8 = null,

    /// The OpenID provider name, if OpenID was used as an authentication mechanism
    /// to access your data models.
    open_id_provider_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cognito_user_pool_id = "CognitoUserPoolId",
        .description = "Description",
        .expiration_time = "ExpirationTime",
        .open_id_auth_ttl = "OpenIDAuthTTL",
        .open_id_client_id = "OpenIDClientId",
        .open_id_iat_ttl = "OpenIDIatTTL",
        .open_id_issue_url = "OpenIDIssueURL",
        .open_id_provider_name = "OpenIDProviderName",
    };
};
