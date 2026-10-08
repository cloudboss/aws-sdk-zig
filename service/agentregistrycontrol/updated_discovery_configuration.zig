const UpdatedAuthorizerConfiguration = @import("updated_authorizer_configuration.zig").UpdatedAuthorizerConfiguration;

/// The discovery configuration fields to update on a registry. Omit this
/// structure to leave the discovery configuration unchanged.
pub const UpdatedDiscoveryConfiguration = struct {
    /// Authorization configuration for the registry, with PATCH semantics
    authorizer_configuration: ?UpdatedAuthorizerConfiguration = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
    };
};
