const ContinuousScanDetails = @import("continuous_scan_details.zig").ContinuousScanDetails;

/// Contains information about the recovery point configuration for scanning
/// backup data from Amazon Web Services Backup.
pub const RecoveryPoint = struct {
    /// The name of the Amazon Web Services Backup vault that contains the name of
    /// the recovery point to be scanned.
    backup_vault_name: []const u8,

    /// Contains information about the time range within the continuous backup in
    /// Amazon Web Services Backup to scan.
    continuous_scan_details: ?ContinuousScanDetails = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .continuous_scan_details = "ContinuousScanDetails",
    };
};
