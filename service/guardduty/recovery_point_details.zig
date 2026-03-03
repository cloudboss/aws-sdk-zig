/// Contains details about the backup recovery point.
pub const RecoveryPointDetails = struct {
    /// The name of the backup vault containing the recovery point.
    backup_vault_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the recovery point.
    recovery_point_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .recovery_point_arn = "RecoveryPointArn",
    };
};
