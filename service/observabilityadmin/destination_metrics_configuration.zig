const MetricsBackupConfiguration = @import("metrics_backup_configuration.zig").MetricsBackupConfiguration;

/// Configuration for centralization destination metrics, including backup
/// settings.
pub const DestinationMetricsConfiguration = struct {
    /// Configuration defining the backup region for the metrics backup destination.
    backup_configuration: ?MetricsBackupConfiguration = null,

    pub const json_field_names = .{
        .backup_configuration = "BackupConfiguration",
    };
};
