/// StripePrivy token response containing appId, basicAuthToken, and optionally
/// authorizationSignature
pub const StripePrivyTokenResponseOutput = struct {
    /// The Privy app ID for the privy-app-id header
    app_id: []const u8,

    /// Base64-encoded ECDSA P-256 authorization signature (only present when
    /// includeAuthorizationSignature is true)
    authorization_signature: ?[]const u8 = null,

    /// Base64-encoded Basic Auth token (appId:appSecret) for the Authorization
    /// header
    basic_auth_token: []const u8,

    /// Unix timestamp in milliseconds when the authorization signature expires. Set
    /// as privy-request-expiry header.
    request_expiry: ?i64 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .authorization_signature = "authorizationSignature",
        .basic_auth_token = "basicAuthToken",
        .request_expiry = "requestExpiry",
    };
};
