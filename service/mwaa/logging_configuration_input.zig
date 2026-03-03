const ModuleLoggingConfigurationInput = @import("module_logging_configuration_input.zig").ModuleLoggingConfigurationInput;

/// Defines the Apache Airflow log types to send to CloudWatch Logs.
pub const LoggingConfigurationInput = struct {
    /// Publishes Airflow DAG processing logs to CloudWatch Logs.
    dag_processing_logs: ?ModuleLoggingConfigurationInput = null,

    /// Publishes Airflow scheduler logs to CloudWatch Logs.
    scheduler_logs: ?ModuleLoggingConfigurationInput = null,

    /// Publishes Airflow task logs to CloudWatch Logs.
    task_logs: ?ModuleLoggingConfigurationInput = null,

    /// Publishes Airflow web server logs to CloudWatch Logs.
    webserver_logs: ?ModuleLoggingConfigurationInput = null,

    /// Publishes Airflow worker logs to CloudWatch Logs.
    worker_logs: ?ModuleLoggingConfigurationInput = null,

    pub const json_field_names = .{
        .dag_processing_logs = "DagProcessingLogs",
        .scheduler_logs = "SchedulerLogs",
        .task_logs = "TaskLogs",
        .webserver_logs = "WebserverLogs",
        .worker_logs = "WorkerLogs",
    };
};
