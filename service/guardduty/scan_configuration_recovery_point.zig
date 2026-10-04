const ScanConfigurationContinuousScanDetails = @import("scan_configuration_continuous_scan_details.zig").ScanConfigurationContinuousScanDetails;

/// Contains information about the recovery point configuration used in the
/// scan.
pub const ScanConfigurationRecoveryPoint = struct {
    /// The name of the Amazon Web Services Backup vault that contains the recovery
    /// point for the scanned.
    backup_vault_name: ?[]const u8 = null,

    /// The time range within the continuous backup in Amazon Web Services Backup
    /// that was scanned for a point-in-time recovery resource.
    continuous_scan_details: ?ScanConfigurationContinuousScanDetails = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .continuous_scan_details = "ContinuousScanDetails",
    };
};
