const aws = @import("aws");

const AuthenticateOidcActionConditionalBehaviorEnum = @import("authenticate_oidc_action_conditional_behavior_enum.zig").AuthenticateOidcActionConditionalBehaviorEnum;

/// Request parameters when using an identity provider (IdP) that is compliant
/// with OpenID
/// Connect (OIDC) to authenticate users.
pub const AuthenticateOidcActionConfig = struct {
    /// The query parameters (up to 10) to include in the redirect request to the
    /// authorization
    /// endpoint.
    authentication_request_extra_params: ?[]const aws.map.StringMapEntry = null,

    /// The authorization endpoint of the IdP. This must be a full URL, including
    /// the HTTPS
    /// protocol, the domain, and the path.
    authorization_endpoint: []const u8,

    /// The OAuth 2.0 client identifier.
    client_id: []const u8,

    /// The OAuth 2.0 client secret. This parameter is required if you are creating
    /// a rule. If you
    /// are modifying a rule, you can omit this parameter if you set
    /// `UseExistingClientSecret` to true.
    client_secret: ?[]const u8 = null,

    /// The OIDC issuer identifier of the IdP. This must be a full URL, including
    /// the HTTPS
    /// protocol, the domain, and the path.
    issuer: []const u8,

    /// The behavior if the user is not authenticated. The following are possible
    /// values:
    ///
    /// * deny`` - Return an HTTP 401 Unauthorized error.
    ///
    /// * allow`` - Allow the request to be forwarded to the target.
    ///
    /// * authenticate`` - Redirect the request to the IdP authorization endpoint.
    ///   This is
    /// the default value.
    on_unauthenticated_request: ?AuthenticateOidcActionConditionalBehaviorEnum = null,

    /// The set of user claims to be requested from the IdP. The default is
    /// `openid`.
    ///
    /// To verify which scope values your IdP supports and how to separate multiple
    /// values, see
    /// the documentation for your IdP.
    scope: ?[]const u8 = null,

    /// The name of the cookie used to maintain session information. The default is
    /// AWSELBAuthSessionCookie.
    session_cookie_name: ?[]const u8 = null,

    /// The maximum duration of the authentication session, in seconds. The default
    /// is 604800
    /// seconds (7 days).
    session_timeout: ?i64 = null,

    /// The token endpoint of the IdP. This must be a full URL, including the HTTPS
    /// protocol, the
    /// domain, and the path.
    token_endpoint: []const u8,

    /// Indicates whether to use the existing client secret when modifying a rule.
    /// If you are
    /// creating a rule, you can omit this parameter or set it to false.
    use_existing_client_secret: ?bool = null,

    /// The user info endpoint of the IdP. This must be a full URL, including the
    /// HTTPS protocol,
    /// the domain, and the path.
    user_info_endpoint: []const u8,
};
