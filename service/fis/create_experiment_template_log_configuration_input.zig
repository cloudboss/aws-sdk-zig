const ExperimentTemplateCloudWatchLogsLogConfigurationInput = @import("experiment_template_cloud_watch_logs_log_configuration_input.zig").ExperimentTemplateCloudWatchLogsLogConfigurationInput;
const ExperimentTemplateS3LogConfigurationInput = @import("experiment_template_s3_log_configuration_input.zig").ExperimentTemplateS3LogConfigurationInput;

/// Specifies the configuration for experiment logging.
pub const CreateExperimentTemplateLogConfigurationInput = struct {
    /// The configuration for experiment logging to Amazon CloudWatch Logs.
    cloud_watch_logs_configuration: ?ExperimentTemplateCloudWatchLogsLogConfigurationInput = null,

    /// The schema version.
    log_schema_version: i32,

    /// The configuration for experiment logging to Amazon S3.
    s_3_configuration: ?ExperimentTemplateS3LogConfigurationInput = null,

    pub const json_field_names = .{
        .cloud_watch_logs_configuration = "cloudWatchLogsConfiguration",
        .log_schema_version = "logSchemaVersion",
        .s_3_configuration = "s3Configuration",
    };
};
