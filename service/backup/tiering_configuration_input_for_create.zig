const ResourceSelection = @import("resource_selection.zig").ResourceSelection;

/// This contains metadata about a tiering configuration for create operations.
pub const TieringConfigurationInputForCreate = struct {
    /// The name of the backup vault where the tiering configuration applies.
    /// Use `*` to apply to all backup vaults.
    backup_vault_name: []const u8,

    /// An array of resource selection objects that specify which resources
    /// are included in the tiering configuration and their tiering settings.
    resource_selection: []const ResourceSelection,

    /// The unique name of the tiering configuration. This cannot be changed
    /// after creation, and it must consist of only alphanumeric characters and
    /// underscores.
    tiering_configuration_name: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .resource_selection = "ResourceSelection",
        .tiering_configuration_name = "TieringConfigurationName",
    };
};
