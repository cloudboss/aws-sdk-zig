const ModuleLoggingConfiguration = @import("module_logging_configuration.zig").ModuleLoggingConfiguration;

/// Describes the Apache Airflow log types that are published to CloudWatch
/// Logs.
pub const LoggingConfiguration = struct {
    /// The Airflow DAG processing logs published to CloudWatch Logs and the log
    /// level.
    dag_processing_logs: ?ModuleLoggingConfiguration = null,

    /// The Airflow scheduler logs published to CloudWatch Logs and the log level.
    scheduler_logs: ?ModuleLoggingConfiguration = null,

    /// The Airflow task logs published to CloudWatch Logs and the log level.
    task_logs: ?ModuleLoggingConfiguration = null,

    /// The Airflow web server logs published to CloudWatch Logs and the log level.
    webserver_logs: ?ModuleLoggingConfiguration = null,

    /// The Airflow worker logs published to CloudWatch Logs and the log level.
    worker_logs: ?ModuleLoggingConfiguration = null,

    pub const json_field_names = .{
        .dag_processing_logs = "DagProcessingLogs",
        .scheduler_logs = "SchedulerLogs",
        .task_logs = "TaskLogs",
        .webserver_logs = "WebserverLogs",
        .worker_logs = "WorkerLogs",
    };
};
