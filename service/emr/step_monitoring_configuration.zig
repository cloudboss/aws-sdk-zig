const S3MonitoringConfiguration = @import("s3_monitoring_configuration.zig").S3MonitoringConfiguration;

/// Object that holds configuration properties for logging.
pub const StepMonitoringConfiguration = struct {
    /// The Amazon S3 configuration for monitoring log publishing. You can configure
    /// your step to send log information
    /// to Amazon S3. When it's specified, it takes precedence over the cluster's
    /// logging configuration. If you don't specify this
    /// configuration entirely, or omit individual fields, EMR falls back to
    /// cluster-level logging behavior.
    s3_monitoring_configuration: ?S3MonitoringConfiguration = null,

    pub const json_field_names = .{
        .s3_monitoring_configuration = "S3MonitoringConfiguration",
    };
};
