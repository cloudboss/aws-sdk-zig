const RegistryAlias = @import("registry_alias.zig").RegistryAlias;

/// The details of a public registry.
pub const Registry = struct {
    /// An array of objects that represents the aliases for a public registry.
    aliases: []const RegistryAlias,

    /// The Amazon Resource Name (ARN) of the public registry.
    registry_arn: []const u8,

    /// The Amazon Web Services account ID that's associated with the registry.
    /// If you do not specify a registry, the default public registry is assumed.
    registry_id: []const u8,

    /// The URI of a public registry. The URI contains a universal prefix and the
    /// registry
    /// alias.
    registry_uri: []const u8,

    /// Indicates whether the account is a verified Amazon Web Services Marketplace
    /// vendor. If an account is verified,
    /// each public repository receives a verified account badge on the
    /// Amazon ECR Public Gallery.
    verified: bool,

    pub const json_field_names = .{
        .aliases = "aliases",
        .registry_arn = "registryArn",
        .registry_id = "registryId",
        .registry_uri = "registryUri",
        .verified = "verified",
    };
};
