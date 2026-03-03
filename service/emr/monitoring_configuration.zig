const CloudWatchLogConfiguration = @import("cloud_watch_log_configuration.zig").CloudWatchLogConfiguration;

/// Contains CloudWatch log configuration metadata and settings.
pub const MonitoringConfiguration = struct {
    /// CloudWatch log configuration settings and metadata that specify settings
    /// like log files to monitor and where to send them.
    cloud_watch_log_configuration: ?CloudWatchLogConfiguration = null,

    pub const json_field_names = .{
        .cloud_watch_log_configuration = "CloudWatchLogConfiguration",
    };
};
