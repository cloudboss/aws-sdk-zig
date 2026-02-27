const RegistryAliasStatus = @import("registry_alias_status.zig").RegistryAliasStatus;

/// An object representing the aliases for a public registry. A public registry
/// is given an
/// alias when it's created. However, a custom alias can be set using the Amazon
/// ECR console. For
/// more information, see
/// [Registries](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html) in the
/// *Amazon Elastic Container Registry User Guide*.
pub const RegistryAlias = struct {
    /// Indicates whether the registry alias is the default alias for the registry.
    /// When the
    /// first public repository is created, your public registry is assigned a
    /// default registry
    /// alias.
    default_registry_alias: bool = false,

    /// The name of the registry alias.
    name: []const u8,

    /// Indicates whether the registry alias is the primary alias for the registry.
    /// If true, the
    /// alias is the primary registry alias and is displayed in both the repository
    /// URL and the
    /// image URI used in the `docker pull` commands on the Amazon ECR Public
    /// Gallery.
    ///
    /// A registry alias that isn't the primary registry alias can be used in the
    /// repository
    /// URI in a `docker pull` command.
    primary_registry_alias: bool = false,

    /// The status of the registry alias.
    status: RegistryAliasStatus,

    pub const json_field_names = .{
        .default_registry_alias = "defaultRegistryAlias",
        .name = "name",
        .primary_registry_alias = "primaryRegistryAlias",
        .status = "status",
    };
};
