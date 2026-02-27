const ResourceSelection = @import("resource_selection.zig").ResourceSelection;

/// This contains metadata about a tiering configuration for update operations.
pub const TieringConfigurationInputForUpdate = struct {
    /// The name of the backup vault where the tiering configuration applies.
    /// Use `*` to apply to all backup vaults.
    backup_vault_name: []const u8,

    /// An array of resource selection objects that specify which resources
    /// are included in the tiering configuration and their tiering settings.
    resource_selection: []const ResourceSelection,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .resource_selection = "ResourceSelection",
    };
};
