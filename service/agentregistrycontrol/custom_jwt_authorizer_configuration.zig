const CustomClaimValidationType = @import("custom_claim_validation_type.zig").CustomClaimValidationType;
const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;
const PrivateEndpointOverride = @import("private_endpoint_override.zig").PrivateEndpointOverride;

/// Configuration for a custom JWT authorizer that validates inbound bearer
/// tokens against an OpenID Connect identity provider.
pub const CustomJWTAuthorizerConfiguration = struct {
    /// The audience values accepted during JWT validation. A token is rejected if
    /// none of its audience claims match.
    allowed_audience: ?[]const []const u8 = null,

    /// The client identifiers accepted during JWT validation. A token is rejected
    /// if it was not issued to one of these clients.
    allowed_clients: ?[]const []const u8 = null,

    /// The scopes accepted during JWT validation. A token is rejected if it does
    /// not carry one of these scopes.
    allowed_scopes: ?[]const []const u8 = null,

    /// Additional custom claim validations applied to the inbound JWT.
    custom_claims: ?[]const CustomClaimValidationType = null,

    /// The OpenID Connect discovery URL used to retrieve the identity provider's
    /// metadata and signing keys.
    discovery_url: []const u8,

    /// The private endpoint used to reach the identity provider's discovery URL
    /// over a private network path.
    private_endpoint: ?PrivateEndpoint = null,

    /// Per-domain private endpoint overrides that route specific identity provider
    /// domains through distinct private endpoints.
    private_endpoint_overrides: ?[]const PrivateEndpointOverride = null,

    pub const json_field_names = .{
        .allowed_audience = "allowedAudience",
        .allowed_clients = "allowedClients",
        .allowed_scopes = "allowedScopes",
        .custom_claims = "customClaims",
        .discovery_url = "discoveryUrl",
        .private_endpoint = "privateEndpoint",
        .private_endpoint_overrides = "privateEndpointOverrides",
    };
};
