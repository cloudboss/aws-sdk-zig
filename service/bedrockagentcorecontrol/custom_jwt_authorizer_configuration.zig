const CustomClaimValidationType = @import("custom_claim_validation_type.zig").CustomClaimValidationType;

/// Configuration for inbound JWT-based authorization, specifying how incoming
/// requests should be authenticated.
pub const CustomJWTAuthorizerConfiguration = struct {
    /// Represents individual audience values that are validated in the incoming JWT
    /// token validation process.
    allowed_audience: ?[]const []const u8 = null,

    /// Represents individual client IDs that are validated in the incoming JWT
    /// token validation process.
    allowed_clients: ?[]const []const u8 = null,

    /// An array of scopes that are allowed to access the token.
    allowed_scopes: ?[]const []const u8 = null,

    /// An array of objects that define a custom claim validation name, value, and
    /// operation
    custom_claims: ?[]const CustomClaimValidationType = null,

    /// This URL is used to fetch OpenID Connect configuration or authorization
    /// server metadata for validating incoming tokens.
    discovery_url: []const u8,

    pub const json_field_names = .{
        .allowed_audience = "allowedAudience",
        .allowed_clients = "allowedClients",
        .allowed_scopes = "allowedScopes",
        .custom_claims = "customClaims",
        .discovery_url = "discoveryUrl",
    };
};
