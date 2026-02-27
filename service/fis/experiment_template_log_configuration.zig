const ExperimentTemplateCloudWatchLogsLogConfiguration = @import("experiment_template_cloud_watch_logs_log_configuration.zig").ExperimentTemplateCloudWatchLogsLogConfiguration;
const ExperimentTemplateS3LogConfiguration = @import("experiment_template_s3_log_configuration.zig").ExperimentTemplateS3LogConfiguration;

/// Describes the configuration for experiment logging.
pub const ExperimentTemplateLogConfiguration = struct {
    /// The configuration for experiment logging to Amazon CloudWatch Logs.
    cloud_watch_logs_configuration: ?ExperimentTemplateCloudWatchLogsLogConfiguration,

    /// The schema version.
    log_schema_version: ?i32,

    /// The configuration for experiment logging to Amazon S3.
    s_3_configuration: ?ExperimentTemplateS3LogConfiguration,

    pub const json_field_names = .{
        .cloud_watch_logs_configuration = "cloudWatchLogsConfiguration",
        .log_schema_version = "logSchemaVersion",
        .s_3_configuration = "s3Configuration",
    };
};
