const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;
const VaultState = @import("vault_state.zig").VaultState;
const VaultType = @import("vault_type.zig").VaultType;

/// Contains metadata about a backup vault.
pub const BackupVaultListMember = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: ?[]const u8,

    /// The date and time a resource backup is created, in Unix format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried
    /// without the risk of running the operation twice. This parameter is optional.
    ///
    /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    creator_request_id: ?[]const u8,

    /// A server-side encryption key you can specify to encrypt your backups from
    /// services
    /// that support full Backup management; for example,
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    /// If you specify a key, you must specify its ARN, not its alias. If you do not
    /// specify a key,
    /// Backup creates a KMS key for you by default.
    ///
    /// To learn which Backup services support full Backup management
    /// and how Backup handles encryption for backups from services that do not yet
    /// support
    /// full Backup, see [
    /// Encryption for backups in
    /// Backup](https://docs.aws.amazon.com/aws-backup/latest/devguide/encryption.html)
    encryption_key_arn: ?[]const u8,

    /// The type of encryption key used for the backup vault. Valid values are
    /// CUSTOMER_MANAGED_KMS_KEY for customer-managed keys or Amazon Web
    /// Services_OWNED_KMS_KEY for Amazon Web Services-owned keys.
    encryption_key_type: ?EncryptionKeyType,

    /// The date and time when Backup Vault Lock configuration becomes immutable,
    /// meaning it cannot be changed or deleted.
    ///
    /// If you applied Vault Lock to your vault without specifying a lock date, you
    /// can change
    /// your Vault Lock settings, or delete Vault Lock from the vault entirely, at
    /// any time.
    ///
    /// This value is in Unix format, Coordinated Universal Time (UTC), and accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    lock_date: ?i64,

    /// A Boolean value that indicates whether Backup Vault Lock applies to the
    /// selected backup vault. If `true`, Vault Lock prevents delete and update
    /// operations on the recovery points in the selected vault.
    locked: ?bool,

    /// The Backup Vault Lock setting that specifies the maximum retention period
    /// that the vault retains its recovery points. If this parameter is not
    /// specified, Vault Lock
    /// does not enforce a maximum retention period on the recovery points in the
    /// vault (allowing
    /// indefinite storage).
    ///
    /// If specified, any backup or copy job to the vault must have a lifecycle
    /// policy with a
    /// retention period equal to or shorter than the maximum retention period. If
    /// the job's
    /// retention period is longer than that maximum retention period, then the
    /// vault fails the
    /// backup or copy job, and you should either modify your lifecycle settings or
    /// use a different
    /// vault. Recovery points already stored in the vault prior to Vault Lock are
    /// not
    /// affected.
    max_retention_days: ?i64,

    /// The Backup Vault Lock setting that specifies the minimum retention period
    /// that the vault retains its recovery points. If this parameter is not
    /// specified, Vault Lock
    /// does not enforce a minimum retention period.
    ///
    /// If specified, any backup or copy job to the vault must have a lifecycle
    /// policy with a
    /// retention period equal to or longer than the minimum retention period. If
    /// the job's
    /// retention period is shorter than that minimum retention period, then the
    /// vault fails the
    /// backup or copy job, and you should either modify your lifecycle settings or
    /// use a different
    /// vault. Recovery points already stored in the vault prior to Vault Lock are
    /// not
    /// affected.
    min_retention_days: ?i64,

    /// The number of recovery points that are stored in a backup vault.
    number_of_recovery_points: i64 = 0,

    /// The current state of the vault.
    vault_state: ?VaultState,

    /// The type of vault in which the described recovery point is stored.
    vault_type: ?VaultType,

    pub const json_field_names = .{
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .creation_date = "CreationDate",
        .creator_request_id = "CreatorRequestId",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_key_type = "EncryptionKeyType",
        .lock_date = "LockDate",
        .locked = "Locked",
        .max_retention_days = "MaxRetentionDays",
        .min_retention_days = "MinRetentionDays",
        .number_of_recovery_points = "NumberOfRecoveryPoints",
        .vault_state = "VaultState",
        .vault_type = "VaultType",
    };
};
