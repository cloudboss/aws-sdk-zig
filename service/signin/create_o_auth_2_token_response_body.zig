const AccessToken = @import("access_token.zig").AccessToken;

/// Response body payload for CreateOAuth2Token operation
///
/// The response content depends on the grant_type from the request:
/// - grant_type=authorization_code: Returns all fields including refresh_token
/// and id_token
/// - grant_type=refresh_token: Returns access_token, token_type, expires_in,
/// refresh_token (no id_token)
pub const CreateOAuth2TokenResponseBody = struct {
    /// Scoped-down AWS credentials (15 minute duration)
    /// Present for both authorization code redemption and token refresh
    access_token: AccessToken,

    /// Time to expiry in seconds (maximum 900)
    /// Present for both authorization code redemption and token refresh
    expires_in: i32,

    /// ID token containing user identity information
    /// Present only in authorization code redemption response
    /// (grant_type=authorization_code)
    /// Not included in token refresh responses
    id_token: ?[]const u8,

    /// Encrypted refresh token with cnf.jkt (SHA-256 thumbprint of presented jwk)
    /// Always present in responses (required for both flows)
    refresh_token: []const u8,

    /// Token type indicating this is AWS SigV4 credentials
    /// Value is "aws_sigv4" for both flows
    token_type: []const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .expires_in = "expiresIn",
        .id_token = "idToken",
        .refresh_token = "refreshToken",
        .token_type = "tokenType",
    };
};
