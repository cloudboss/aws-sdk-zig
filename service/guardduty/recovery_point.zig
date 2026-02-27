/// Contains information about the recovery point configuration for scanning
/// backup data from Amazon Web Services Backup.
pub const RecoveryPoint = struct {
    /// The name of the Amazon Web Services Backup vault that contains the name of
    /// the recovery point to be scanned.
    backup_vault_name: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
    };
};
