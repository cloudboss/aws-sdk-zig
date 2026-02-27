/// Contains the OpenID Connect (OIDC) configuration information for Single
/// Sign-On (SSO) authentication, including identity provider settings and
/// client credentials.
pub const OidcConfigInfo = struct {
    /// The unique identifier for the registered OIDC application. Valid range is
    /// 1-10.
    application_id: ?i32,

    /// The name of the OIDC application as registered with the identity provider.
    application_name: ?[]const u8,

    /// The X.509 CA certificate for validating SSL/TLS connections to the identity
    /// provider when using self-signed or enterprise certificates.
    ca_certificate: ?[]const u8,

    /// The OAuth client ID assigned by the identity provider for authentication
    /// requests.
    client_id: ?[]const u8,

    /// The OAuth client secret used to authenticate the application with the
    /// identity provider.
    client_secret: ?[]const u8,

    /// Custom identifier your end users will use to sign in with SSO.
    company_id: []const u8,

    /// A custom field mapping to extract the username from the OIDC token when the
    /// standard username claim is insufficient.
    custom_username: ?[]const u8,

    /// Additional authentication parameters to include in the OIDC authorization
    /// request as a query string. Useful for provider-specific extensions.
    extra_auth_params: ?[]const u8,

    /// The issuer URL of the identity provider, which serves as the base URL for
    /// OIDC endpoints and configuration discovery.
    issuer: []const u8,

    /// The callback URL where the identity provider redirects users after
    /// successful authentication. This URL must be registered with the identity
    /// provider.
    redirect_url: ?[]const u8,

    /// The OAuth scopes requested from the identity provider, which determine what
    /// user information is accessible (e.g., 'openid profile email').
    scopes: []const u8,

    /// An additional secret credential used by the identity provider for
    /// authentication.
    secret: ?[]const u8,

    /// The grace period in minutes before the SSO token expires when the system
    /// should proactively refresh the token to maintain seamless user access.
    sso_token_buffer_minutes: ?i32,

    /// The claim field from the OIDC token to use as the unique user identifier
    /// (e.g., 'email', 'sub', or a custom claim).
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_name = "applicationName",
        .ca_certificate = "caCertificate",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .company_id = "companyId",
        .custom_username = "customUsername",
        .extra_auth_params = "extraAuthParams",
        .issuer = "issuer",
        .redirect_url = "redirectUrl",
        .scopes = "scopes",
        .secret = "secret",
        .sso_token_buffer_minutes = "ssoTokenBufferMinutes",
        .user_id = "userId",
    };
};
