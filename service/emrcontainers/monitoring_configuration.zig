const CloudWatchMonitoringConfiguration = @import("cloud_watch_monitoring_configuration.zig").CloudWatchMonitoringConfiguration;
const ContainerLogRotationConfiguration = @import("container_log_rotation_configuration.zig").ContainerLogRotationConfiguration;
const ManagedLogs = @import("managed_logs.zig").ManagedLogs;
const PersistentAppUI = @import("persistent_app_ui.zig").PersistentAppUI;
const S3MonitoringConfiguration = @import("s3_monitoring_configuration.zig").S3MonitoringConfiguration;

/// Configuration setting for monitoring.
pub const MonitoringConfiguration = struct {
    /// Monitoring configurations for CloudWatch.
    cloud_watch_monitoring_configuration: ?CloudWatchMonitoringConfiguration = null,

    /// Enable or disable container log rotation.
    container_log_rotation_configuration: ?ContainerLogRotationConfiguration = null,

    /// The entity that controls configuration for managed logs.
    managed_logs: ?ManagedLogs = null,

    /// Monitoring configurations for the persistent application UI.
    persistent_app_ui: ?PersistentAppUI = null,

    /// Amazon S3 configuration for monitoring log publishing.
    s_3_monitoring_configuration: ?S3MonitoringConfiguration = null,

    pub const json_field_names = .{
        .cloud_watch_monitoring_configuration = "cloudWatchMonitoringConfiguration",
        .container_log_rotation_configuration = "containerLogRotationConfiguration",
        .managed_logs = "managedLogs",
        .persistent_app_ui = "persistentAppUI",
        .s_3_monitoring_configuration = "s3MonitoringConfiguration",
    };
};
