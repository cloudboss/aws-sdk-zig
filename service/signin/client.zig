const aws = @import("aws");
const std = @import("std");

const create_o_auth_2_token = @import("create_o_auth_2_token.zig");
const create_o_auth_2_token_with_iam = @import("create_o_auth_2_token_with_iam.zig");
const delete_console_authorization_configuration = @import("delete_console_authorization_configuration.zig");
const delete_resource_permission_statement = @import("delete_resource_permission_statement.zig");
const get_console_authorization_configuration = @import("get_console_authorization_configuration.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const introspect_o_auth_2_token_with_iam = @import("introspect_o_auth_2_token_with_iam.zig");
const list_resource_permission_statements = @import("list_resource_permission_statements.zig");
const put_console_authorization_configuration = @import("put_console_authorization_configuration.zig");
const put_resource_permission_statement = @import("put_resource_permission_statement.zig");
const revoke_o_auth_2_token_with_iam = @import("revoke_o_auth_2_token_with_iam.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Signin";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
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
    pub fn createOAuth2Token(self: *Self, allocator: std.mem.Allocator, input: create_o_auth_2_token.CreateOAuth2TokenInput, options: CallOptions) !create_o_auth_2_token.CreateOAuth2TokenOutput {
        return create_o_auth_2_token.execute(self, allocator, input, options);
    }

    /// Grants permission to exchange client credentials for an OAuth 2.0 access
    /// token
    /// scoped to a resource that can be used to access AWS services from
    /// applications
    pub fn createOAuth2TokenWithIam(self: *Self, allocator: std.mem.Allocator, input: create_o_auth_2_token_with_iam.CreateOAuth2TokenWithIAMInput, options: CallOptions) !create_o_auth_2_token_with_iam.CreateOAuth2TokenWithIAMOutput {
        return create_o_auth_2_token_with_iam.execute(self, allocator, input, options);
    }

    /// Delete console authorization configuration with automatic scope detection
    pub fn deleteConsoleAuthorizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_console_authorization_configuration.DeleteConsoleAuthorizationConfigurationInput, options: CallOptions) !delete_console_authorization_configuration.DeleteConsoleAuthorizationConfigurationOutput {
        return delete_console_authorization_configuration.execute(self, allocator, input, options);
    }

    /// Remove a permission statement from the account's SignIn resource-based
    /// policy
    pub fn deleteResourcePermissionStatement(self: *Self, allocator: std.mem.Allocator, input: delete_resource_permission_statement.DeleteResourcePermissionStatementInput, options: CallOptions) !delete_resource_permission_statement.DeleteResourcePermissionStatementOutput {
        return delete_resource_permission_statement.execute(self, allocator, input, options);
    }

    /// Get console authorization configuration with automatic scope detection
    pub fn getConsoleAuthorizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_console_authorization_configuration.GetConsoleAuthorizationConfigurationInput, options: CallOptions) !get_console_authorization_configuration.GetConsoleAuthorizationConfigurationOutput {
        return get_console_authorization_configuration.execute(self, allocator, input, options);
    }

    /// Retrieve the account's consolidated SignIn resource-based policy
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Grants permission to inspect the metadata and state of an OAuth 2.0
    /// access token or refresh token
    ///
    /// Implements RFC 7662 OAuth 2.0 Token Introspection over a SigV4-authenticated
    /// endpoint. Inspects the metadata of an access_token or refresh_token issued
    /// by AWS Sign-In and returns the claims associated with it.
    ///
    /// Inactive token semantics (RFC 7662 §2.2): when the supplied token is
    /// unknown, expired, revoked, malformed, or owned by a different account,
    /// the response body is exactly { "active": false } with all other claims
    /// omitted.
    pub fn introspectOAuth2TokenWithIam(self: *Self, allocator: std.mem.Allocator, input: introspect_o_auth_2_token_with_iam.IntrospectOAuth2TokenWithIAMInput, options: CallOptions) !introspect_o_auth_2_token_with_iam.IntrospectOAuth2TokenWithIAMOutput {
        return introspect_o_auth_2_token_with_iam.execute(self, allocator, input, options);
    }

    /// Retrieve all permission statements in the account's SignIn resource-based
    /// policy
    pub fn listResourcePermissionStatements(self: *Self, allocator: std.mem.Allocator, input: list_resource_permission_statements.ListResourcePermissionStatementsInput, options: CallOptions) !list_resource_permission_statements.ListResourcePermissionStatementsOutput {
        return list_resource_permission_statements.execute(self, allocator, input, options);
    }

    /// Enable console authorization configuration with automatic scope detection
    pub fn putConsoleAuthorizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_console_authorization_configuration.PutConsoleAuthorizationConfigurationInput, options: CallOptions) !put_console_authorization_configuration.PutConsoleAuthorizationConfigurationOutput {
        return put_console_authorization_configuration.execute(self, allocator, input, options);
    }

    /// Create a permission statement in the account's SignIn resource-based policy
    pub fn putResourcePermissionStatement(self: *Self, allocator: std.mem.Allocator, input: put_resource_permission_statement.PutResourcePermissionStatementInput, options: CallOptions) !put_resource_permission_statement.PutResourcePermissionStatementOutput {
        return put_resource_permission_statement.execute(self, allocator, input, options);
    }

    /// Grants permission to revoke an OAuth 2.0 refresh token and its associated
    /// refresh tokens
    ///
    /// Revokes a refresh_token issued by AWS Sign-In, invalidating the entire token
    /// chain so that the refresh_token can no longer be used to mint new
    /// access_tokens.
    ///
    /// Idempotency: revoking an already-revoked, expired, or otherwise invalid
    /// token
    /// still returns 200 OK with an empty body. Only the refresh_token type is
    /// accepted.
    pub fn revokeOAuth2TokenWithIam(self: *Self, allocator: std.mem.Allocator, input: revoke_o_auth_2_token_with_iam.RevokeOAuth2TokenWithIAMInput, options: CallOptions) !revoke_o_auth_2_token_with_iam.RevokeOAuth2TokenWithIAMOutput {
        return revoke_o_auth_2_token_with_iam.execute(self, allocator, input, options);
    }

    pub fn listResourcePermissionStatementsPaginator(self: *Self, params: list_resource_permission_statements.ListResourcePermissionStatementsInput) paginator.ListResourcePermissionStatementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
