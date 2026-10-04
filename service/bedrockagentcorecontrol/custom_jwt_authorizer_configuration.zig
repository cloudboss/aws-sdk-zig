const aws = @import("aws");

const AllowedWorkloadConfiguration = @import("allowed_workload_configuration.zig").AllowedWorkloadConfiguration;
const CustomClaimValidationType = @import("custom_claim_validation_type.zig").CustomClaimValidationType;
const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;
const PrivateEndpointOverride = @import("private_endpoint_override.zig").PrivateEndpointOverride;

/// Configuration for inbound JWT-based authorization, specifying how incoming
/// requests should be authenticated.
pub const CustomJWTAuthorizerConfiguration = struct {
    /// A map that associates each scope in `allowedScopes` with a corresponding
    /// advertised scope value. The advertised scope appears in OAuth protected
    /// resource metadata and `WWW-Authenticate` response headers. Use this
    /// parameter when the scope that clients request from your identity provider
    /// differs from the scope in the validated token. Each key is a scope from
    /// `allowedScopes` that the service uses for token validation. Each value is
    /// the corresponding scope that the service advertises to clients. Scopes
    /// without a mapping entry appear unchanged to clients.
    advertised_scope_mapping: ?[]const aws.map.StringMapEntry = null,

    /// Represents individual audience values that are validated in the incoming JWT
    /// token validation process.
    allowed_audience: ?[]const []const u8 = null,

    /// Represents individual client IDs that are validated in the incoming JWT
    /// token validation process.
    allowed_clients: ?[]const []const u8 = null,

    /// An array of scopes that are allowed to access the token.
    allowed_scopes: ?[]const []const u8 = null,

    /// The configuration that restricts which workloads in the request's identity
    /// chain are allowed to invoke the target, identified by their hosting
    /// environments and workload identities. At launch, this is supported only for
    /// AgentCore Runtime targets, and the allowed workloads are AgentCore Gateways.
    allowed_workload_configuration: ?AllowedWorkloadConfiguration = null,

    /// An array of objects that define a custom claim validation name, value, and
    /// operation
    custom_claims: ?[]const CustomClaimValidationType = null,

    /// This URL is used to fetch OpenID Connect configuration or authorization
    /// server metadata for validating incoming tokens.
    discovery_url: []const u8,

    private_endpoint: ?PrivateEndpoint = null,

    /// The private endpoint overrides for the custom JWT authorizer configuration.
    private_endpoint_overrides: ?[]const PrivateEndpointOverride = null,

    pub const json_field_names = .{
        .advertised_scope_mapping = "advertisedScopeMapping",
        .allowed_audience = "allowedAudience",
        .allowed_clients = "allowedClients",
        .allowed_scopes = "allowedScopes",
        .allowed_workload_configuration = "allowedWorkloadConfiguration",
        .custom_claims = "customClaims",
        .discovery_url = "discoveryUrl",
        .private_endpoint = "privateEndpoint",
        .private_endpoint_overrides = "privateEndpointOverrides",
    };
};
