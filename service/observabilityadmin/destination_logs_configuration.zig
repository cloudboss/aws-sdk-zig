const LogsBackupConfiguration = @import("logs_backup_configuration.zig").LogsBackupConfiguration;
const LogGroupNameConfiguration = @import("log_group_name_configuration.zig").LogGroupNameConfiguration;
const LogsEncryptionConfiguration = @import("logs_encryption_configuration.zig").LogsEncryptionConfiguration;

/// Configuration for centralization destination log groups, including
/// encryption and backup settings.
pub const DestinationLogsConfiguration = struct {
    /// Configuration defining the backup region and an optional KMS key for the
    /// backup destination.
    backup_configuration: ?LogsBackupConfiguration = null,

    /// Configuration that specifies a naming pattern for destination log groups
    /// created during centralization. The pattern supports static text and dynamic
    /// variables that are replaced with source attributes when log groups are
    /// created.
    log_group_name_configuration: ?LogGroupNameConfiguration = null,

    /// The encryption configuration for centralization destination log groups.
    logs_encryption_configuration: ?LogsEncryptionConfiguration = null,

    pub const json_field_names = .{
        .backup_configuration = "BackupConfiguration",
        .log_group_name_configuration = "LogGroupNameConfiguration",
        .logs_encryption_configuration = "LogsEncryptionConfiguration",
    };
};
