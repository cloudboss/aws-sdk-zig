const AwsBackupBackupVaultNotificationsDetails = @import("aws_backup_backup_vault_notifications_details.zig").AwsBackupBackupVaultNotificationsDetails;

/// Provides details about an Backup backup vault. In Backup, a backup vault is
/// a container that stores and organizes your backups.
pub const AwsBackupBackupVaultDetails = struct {
    /// A resource-based policy that is used to manage access permissions on the
    /// target backup vault.
    access_policy: ?[]const u8 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified by names that are unique to the
    /// Amazon Web Services account used to create them and the Amazon Web Services
    /// Region where they are created.
    /// They consist of lowercase letters, numbers, and hyphens.
    backup_vault_name: ?[]const u8 = null,

    /// The unique ARN associated with the server-side encryption key. You can
    /// specify a key to encrypt your backups from services that support
    /// full Backup management. If you don't specify a key, Backup creates an KMS
    /// key for you by default.
    encryption_key_arn: ?[]const u8 = null,

    /// The Amazon SNS event notifications for the specified backup vault.
    notifications: ?AwsBackupBackupVaultNotificationsDetails = null,

    pub const json_field_names = .{
        .access_policy = "AccessPolicy",
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .encryption_key_arn = "EncryptionKeyArn",
        .notifications = "Notifications",
    };
};
