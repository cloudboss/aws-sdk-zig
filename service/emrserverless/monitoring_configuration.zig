const CloudWatchLoggingConfiguration = @import("cloud_watch_logging_configuration.zig").CloudWatchLoggingConfiguration;
const ManagedPersistenceMonitoringConfiguration = @import("managed_persistence_monitoring_configuration.zig").ManagedPersistenceMonitoringConfiguration;
const PrometheusMonitoringConfiguration = @import("prometheus_monitoring_configuration.zig").PrometheusMonitoringConfiguration;
const S3MonitoringConfiguration = @import("s3_monitoring_configuration.zig").S3MonitoringConfiguration;

/// The configuration setting for monitoring.
pub const MonitoringConfiguration = struct {
    /// The Amazon CloudWatch configuration for monitoring logs. You can configure
    /// your jobs to send log information to CloudWatch.
    cloud_watch_logging_configuration: ?CloudWatchLoggingConfiguration = null,

    /// The managed log persistence configuration for a job run.
    managed_persistence_monitoring_configuration: ?ManagedPersistenceMonitoringConfiguration = null,

    /// The monitoring configuration object you can configure to send metrics to
    /// Amazon Managed Service for Prometheus for a job run.
    prometheus_monitoring_configuration: ?PrometheusMonitoringConfiguration = null,

    /// The Amazon S3 configuration for monitoring log publishing.
    s_3_monitoring_configuration: ?S3MonitoringConfiguration = null,

    pub const json_field_names = .{
        .cloud_watch_logging_configuration = "cloudWatchLoggingConfiguration",
        .managed_persistence_monitoring_configuration = "managedPersistenceMonitoringConfiguration",
        .prometheus_monitoring_configuration = "prometheusMonitoringConfiguration",
        .s_3_monitoring_configuration = "s3MonitoringConfiguration",
    };
};
