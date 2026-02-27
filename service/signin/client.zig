const aws = @import("aws");
const std = @import("std");

const create_o_auth_2_token = @import("create_o_auth_2_token.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Signin";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// CreateOAuth2Token API
    ///
    /// Path: /v1/token
    /// Request Method: POST
    /// Content-Type: application/json or application/x-www-form-urlencoded
    ///
    /// This API implements OAuth 2.0 flows for AWS Sign-In CLI clients, supporting
    /// both:
    /// 1. Authorization code redemption (grant_type=authorization_code) - NOT
    /// idempotent
    /// 2. Token refresh (grant_type=refresh_token) - Idempotent within token
    /// validity window
    ///
    /// The operation behavior is determined by the grant_type parameter in the
    /// request body:
    ///
    /// **Authorization Code Flow (NOT Idempotent):**
    /// - JSON or form-encoded body with client_id, grant_type=authorization_code,
    /// code, redirect_uri, code_verifier
    /// - Returns access_token, token_type, expires_in, refresh_token, and id_token
    /// - Each authorization code can only be used ONCE for security (prevents
    /// replay attacks)
    ///
    /// **Token Refresh Flow (Idempotent):**
    /// - JSON or form-encoded body with client_id, grant_type=refresh_token,
    /// refresh_token
    /// - Returns access_token, token_type, expires_in, and refresh_token (no
    /// id_token)
    /// - Multiple calls with same refresh_token return consistent results within
    /// validity window
    ///
    /// Authentication and authorization:
    /// - Confidential clients: sigv4 signing required with signin:ExchangeToken
    /// permissions
    /// - CLI clients (public): authn/authz skipped based on client_id & grant_type
    ///
    /// Note: This operation cannot be marked as @idempotent because it handles both
    /// idempotent
    /// (token refresh) and non-idempotent (auth code redemption) flows in a single
    /// endpoint.
    pub fn createOAuth2Token(self: *Self, allocator: std.mem.Allocator, input: create_o_auth_2_token.CreateOAuth2TokenInput, options: create_o_auth_2_token.Options) !create_o_auth_2_token.CreateOAuth2TokenOutput {
        return create_o_auth_2_token.execute(self, allocator, input, options);
    }
};
