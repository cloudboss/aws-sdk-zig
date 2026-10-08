const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const RegistryAuthorizerType = @import("registry_authorizer_type.zig").RegistryAuthorizerType;

/// Discovery configuration for the registry. Controls how consumers are
/// authorized to search the registry and invoke its MCP endpoint.
pub const DiscoveryConfiguration = struct {
    /// The authorizer configuration for the registry. Required when authorizerType
    /// is CUSTOM_JWT.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The type of authorizer that controls how consumers access the registry's
    /// search and MCP invoke operations.
    authorizer_type: ?RegistryAuthorizerType = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
    };
};
