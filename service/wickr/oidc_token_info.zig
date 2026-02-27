/// Contains OAuth token information returned from the identity provider,
/// including access tokens, ID tokens, and PKCE parameters used for secure
/// authentication.
pub const OidcTokenInfo = struct {
    /// The OAuth access token that can be used to access protected resources on
    /// behalf of the authenticated user.
    access_token: ?[]const u8,

    /// The PKCE code challenge, a transformed version of the code verifier sent
    /// during the authorization request for verification.
    code_challenge: ?[]const u8,

    /// The PKCE (Proof Key for Code Exchange) code verifier, a cryptographically
    /// random string used to enhance security in the OAuth flow.
    code_verifier: ?[]const u8,

    /// The lifetime of the access token in seconds, indicating when the token will
    /// expire and need to be refreshed.
    expires_in: ?i64,

    /// The OpenID Connect ID token containing user identity information and
    /// authentication context as a signed JWT.
    id_token: ?[]const u8,

    /// The OAuth refresh token that can be used to obtain new access tokens without
    /// requiring the user to re-authenticate.
    refresh_token: ?[]const u8,

    /// The type of access token issued, typically 'Bearer', which indicates how the
    /// token should be used in API requests.
    token_type: ?[]const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .code_challenge = "codeChallenge",
        .code_verifier = "codeVerifier",
        .expires_in = "expiresIn",
        .id_token = "idToken",
        .refresh_token = "refreshToken",
        .token_type = "tokenType",
    };
};
