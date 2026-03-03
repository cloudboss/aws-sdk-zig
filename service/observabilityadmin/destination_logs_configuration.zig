const LogsBackupConfiguration = @import("logs_backup_configuration.zig").LogsBackupConfiguration;
const LogsEncryptionConfiguration = @import("logs_encryption_configuration.zig").LogsEncryptionConfiguration;

/// Configuration for centralization destination log groups, including
/// encryption and backup settings.
pub const DestinationLogsConfiguration = struct {
    /// Configuration defining the backup region and an optional KMS key for the
    /// backup destination.
    backup_configuration: ?LogsBackupConfiguration = null,

    /// The encryption configuration for centralization destination log groups.
    logs_encryption_configuration: ?LogsEncryptionConfiguration = null,

    pub const json_field_names = .{
        .backup_configuration = "BackupConfiguration",
        .logs_encryption_configuration = "LogsEncryptionConfiguration",
    };
};
