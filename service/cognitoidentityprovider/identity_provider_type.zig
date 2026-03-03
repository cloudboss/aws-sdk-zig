const aws = @import("aws");

const IdentityProviderTypeType = @import("identity_provider_type_type.zig").IdentityProviderTypeType;

/// A user pool identity provider (IdP). Contains information about a
/// third-party IdP to a
/// user pool, the attributes that it populates to user profiles, and the trust
/// relationship
/// between the IdP and your user pool.
pub const IdentityProviderType = struct {
    /// A mapping of IdP attributes to standard and custom user pool attributes.
    attribute_mapping: ?[]const aws.map.StringMapEntry = null,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64 = null,

    /// A list of IdP identifiers. IdP identifiers are strings that represent
    /// friendly names
    /// or domain names of IdPs, for example `MyIdP` or
    /// `auth.example.com`. You can choose to route user authorization requests to
    /// the right IdP with either IdP identifiers or IdP names. For more
    /// information, see
    /// `identity_provider` and `idp_identifier` at [Authorize
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html#get-authorize-request-parameters).
    idp_identifiers: ?[]const []const u8 = null,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64 = null,

    /// The scopes, URLs, and identifiers for your external identity provider. The
    /// following
    /// examples describe the provider detail keys for each IdP type. These values
    /// and their
    /// schema are subject to change. Social IdP `authorize_scopes` values must
    /// match
    /// the values listed here.
    ///
    /// **OpenID Connect (OIDC)**
    ///
    /// Amazon Cognito accepts the following elements when it can't discover
    /// endpoint
    /// URLs from `oidc_issuer`: `attributes_url`,
    /// `authorize_url`, `jwks_uri`,
    /// `token_url`.
    ///
    /// Create or update request: `"ProviderDetails": {
    /// "attributes_request_method": "GET", "attributes_url":
    /// "https://auth.example.com/userInfo", "authorize_scopes": "openid profile
    /// email", "authorize_url": "https://auth.example.com/authorize",
    /// "client_id": "1example23456789", "client_secret":
    /// "provider-app-client-secret", "jwks_uri":
    /// "https://auth.example.com/.well-known/jwks.json", "oidc_issuer":
    /// "https://auth.example.com", "token_url": "https://example.com/token"
    /// }`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_request_method":
    /// "GET", "attributes_url": "https://auth.example.com/userInfo",
    /// "attributes_url_add_attributes": "false", "authorize_scopes": "openid
    /// profile email", "authorize_url": "https://auth.example.com/authorize",
    /// "client_id": "1example23456789", "client_secret":
    /// "provider-app-client-secret", "jwks_uri":
    /// "https://auth.example.com/.well-known/jwks.json", "oidc_issuer":
    /// "https://auth.example.com", "token_url": "https://example.com/token"
    /// }`
    ///
    /// **SAML**
    ///
    /// Create or update request with Metadata URL: `"ProviderDetails": { "IDPInit":
    /// "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true", "MetadataURL":
    /// "https://auth.example.com/sso/saml/metadata", "RequestSigningAlgorithm":
    /// "rsa-sha256" }`
    ///
    /// Create or update request with Metadata file: `"ProviderDetails": {
    /// "IDPInit": "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true",
    /// "MetadataFile": "[metadata XML]", "RequestSigningAlgorithm":
    /// "rsa-sha256" }`
    ///
    /// The value of `MetadataFile` must be the plaintext metadata document with all
    /// quote (") characters escaped by backslashes.
    ///
    /// Describe response: `"ProviderDetails": { "IDPInit": "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true",
    /// "ActiveEncryptionCertificate": "[certificate]",
    /// "MetadataURL": "https://auth.example.com/sso/saml/metadata",
    /// "RequestSigningAlgorithm":
    /// "rsa-sha256", "SLORedirectBindingURI":
    /// "https://auth.example.com/slo/saml", "SSORedirectBindingURI":
    /// "https://auth.example.com/sso/saml" }`
    ///
    /// **LoginWithAmazon**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "profile postal_code", "client_id":
    /// "amzn1.application-oa2-client.1example23456789", "client_secret":
    /// "provider-app-client-secret"`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_url":
    /// "https://api.amazon.com/user/profile", "attributes_url_add_attributes":
    /// "false", "authorize_scopes": "profile postal_code", "authorize_url":
    /// "https://www.amazon.com/ap/oa", "client_id":
    /// "amzn1.application-oa2-client.1example23456789", "client_secret":
    /// "provider-app-client-secret", "token_request_method": "POST",
    /// "token_url": "https://api.amazon.com/auth/o2/token" }`
    ///
    /// **Google**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "email profile openid", "client_id":
    /// "1example23456789.apps.googleusercontent.com", "client_secret":
    /// "provider-app-client-secret" }`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_url":
    /// "https://people.googleapis.com/v1/people/me?personFields=",
    /// "attributes_url_add_attributes": "true", "authorize_scopes": "email
    /// profile openid", "authorize_url":
    /// "https://accounts.google.com/o/oauth2/v2/auth", "client_id":
    /// "1example23456789.apps.googleusercontent.com", "client_secret":
    /// "provider-app-client-secret", "oidc_issuer":
    /// "https://accounts.google.com", "token_request_method": "POST",
    /// "token_url": "https://www.googleapis.com/oauth2/v4/token"
    /// }`
    ///
    /// **SignInWithApple**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "email name", "client_id": "com.example.cognito", "private_key": "1EXAMPLE",
    /// "key_id": "2EXAMPLE", "team_id": "3EXAMPLE" }`
    ///
    /// Describe response: `"ProviderDetails": {
    /// "attributes_url_add_attributes": "false", "authorize_scopes": "email
    /// name", "authorize_url": "https://appleid.apple.com/auth/authorize",
    /// "client_id": "com.example.cognito", "key_id": "1EXAMPLE", "oidc_issuer":
    /// "https://appleid.apple.com", "team_id": "2EXAMPLE",
    /// "token_request_method": "POST", "token_url":
    /// "https://appleid.apple.com/auth/token" }`
    ///
    /// **Facebook**
    ///
    /// Create or update request: `"ProviderDetails": { "api_version": "v17.0",
    /// "authorize_scopes": "public_profile, email", "client_id":
    /// "1example23456789",
    /// "client_secret": "provider-app-client-secret" }`
    ///
    /// Describe response: `"ProviderDetails":
    /// { "api_version": "v17.0", "attributes_url":
    /// "https://graph.facebook.com/v17.0/me?fields=",
    /// "attributes_url_add_attributes": "true", "authorize_scopes":
    /// "public_profile, email",
    /// "authorize_url": "https://www.facebook.com/v17.0/dialog/oauth", "client_id":
    /// "1example23456789", "client_secret": "provider-app-client-secret",
    /// "token_request_method":
    /// "GET", "token_url": "https://graph.facebook.com/v17.0/oauth/access_token" }`
    provider_details: ?[]const aws.map.StringMapEntry = null,

    /// A friendly name for the IdP.
    provider_name: ?[]const u8 = null,

    /// The type of IdP. Either SAML, OIDC, or a named social identity provider.
    provider_type: ?IdentityProviderTypeType = null,

    /// The ID of the user pool associated with the IdP.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_mapping = "AttributeMapping",
        .creation_date = "CreationDate",
        .idp_identifiers = "IdpIdentifiers",
        .last_modified_date = "LastModifiedDate",
        .provider_details = "ProviderDetails",
        .provider_name = "ProviderName",
        .provider_type = "ProviderType",
        .user_pool_id = "UserPoolId",
    };
};
