/// Contains information about the recovery point configuration used in the
/// scan.
pub const ScanConfigurationRecoveryPoint = struct {
    /// The name of the Amazon Web Services Backup vault that contains the recovery
    /// point for the scanned.
    backup_vault_name: ?[]const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
    };
};
