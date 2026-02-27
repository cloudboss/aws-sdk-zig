/// Request body payload for CreateOAuth2Token operation
///
/// The operation type is determined by the grant_type parameter:
/// - grant_type=authorization_code: Requires code, redirect_uri, code_verifier
/// - grant_type=refresh_token: Requires refresh_token
pub const CreateOAuth2TokenRequestBody = struct {
    /// The client identifier (ARN) used during Sign-In onboarding
    /// Required for both authorization code and refresh token flows
    client_id: []const u8,

    /// The authorization code received from /v1/authorize
    /// Required only when grant_type=authorization_code
    code: ?[]const u8,

    /// PKCE code verifier to prove possession of the original code challenge
    /// Required only when grant_type=authorization_code
    code_verifier: ?[]const u8,

    /// OAuth 2.0 grant type - determines which flow is used
    /// Must be "authorization_code" or "refresh_token"
    grant_type: []const u8,

    /// The redirect URI that must match the original authorization request
    /// Required only when grant_type=authorization_code
    redirect_uri: ?[]const u8,

    /// The refresh token returned from auth_code redemption
    /// Required only when grant_type=refresh_token
    refresh_token: ?[]const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .code = "code",
        .code_verifier = "codeVerifier",
        .grant_type = "grantType",
        .redirect_uri = "redirectUri",
        .refresh_token = "refreshToken",
    };
};
