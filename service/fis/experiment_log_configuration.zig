const ExperimentCloudWatchLogsLogConfiguration = @import("experiment_cloud_watch_logs_log_configuration.zig").ExperimentCloudWatchLogsLogConfiguration;
const ExperimentS3LogConfiguration = @import("experiment_s3_log_configuration.zig").ExperimentS3LogConfiguration;

/// Describes the configuration for experiment logging.
pub const ExperimentLogConfiguration = struct {
    /// The configuration for experiment logging to Amazon CloudWatch Logs.
    cloud_watch_logs_configuration: ?ExperimentCloudWatchLogsLogConfiguration = null,

    /// The schema version.
    log_schema_version: ?i32 = null,

    /// The configuration for experiment logging to Amazon S3.
    s_3_configuration: ?ExperimentS3LogConfiguration = null,

    pub const json_field_names = .{
        .cloud_watch_logs_configuration = "cloudWatchLogsConfiguration",
        .log_schema_version = "logSchemaVersion",
        .s_3_configuration = "s3Configuration",
    };
};
