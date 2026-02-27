/// Configuration for workflow logging that specifies where you should store
/// your workflow execution logs. Amazon Managed Workflows for Apache Airflow
/// Serverless provides comprehensive logging capabilities that capture workflow
/// execution details, task-level information, and system events. Logs are
/// automatically exported to your specified CloudWatch log group using remote
/// logging functionality, providing centralized observability across the
/// distributed, multi-tenant execution environment. This enables effective
/// debugging, monitoring, and compliance auditing of workflow executions.
pub const LoggingConfiguration = struct {
    /// The name of the CloudWatch log group where workflow execution logs are
    /// stored.
    log_group_name: []const u8,

    pub const json_field_names = .{
        .log_group_name = "LogGroupName",
    };
};
