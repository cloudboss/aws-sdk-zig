const ParametricCloudWatchMonitoringConfiguration = @import("parametric_cloud_watch_monitoring_configuration.zig").ParametricCloudWatchMonitoringConfiguration;
const ParametricS3MonitoringConfiguration = @import("parametric_s3_monitoring_configuration.zig").ParametricS3MonitoringConfiguration;

/// Configuration setting for monitoring. This data type allows job template
/// parameters to
/// be specified within.
pub const ParametricMonitoringConfiguration = struct {
    /// Monitoring configurations for CloudWatch.
    cloud_watch_monitoring_configuration: ?ParametricCloudWatchMonitoringConfiguration = null,

    /// Monitoring configurations for the persistent application UI.
    persistent_app_ui: ?[]const u8 = null,

    /// Amazon S3 configuration for monitoring log publishing.
    s_3_monitoring_configuration: ?ParametricS3MonitoringConfiguration = null,

    pub const json_field_names = .{
        .cloud_watch_monitoring_configuration = "cloudWatchMonitoringConfiguration",
        .persistent_app_ui = "persistentAppUI",
        .s_3_monitoring_configuration = "s3MonitoringConfiguration",
    };
};
