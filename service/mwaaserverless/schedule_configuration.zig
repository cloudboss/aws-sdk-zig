/// The configuration to use to schedule automated workflow execution using cron
/// expressions. Amazon Managed Workflows for Apache Airflow Serverless
/// integrates with EventBridge Scheduler to provide cost-effective,
/// timezone-aware scheduling capabilities. The service supports both time-based
/// and event-based scheduling (event-based scheduling available post-GA). When
/// a workflow definition includes scheduling information, Amazon Managed
/// Workflows for Apache Airflow Serverless automatically configures the
/// appropriate triggers and ensures only one version of a workflow has an
/// active schedule at any time.
pub const ScheduleConfiguration = struct {
    /// A cron expression that defines when the workflow is automatically executed.
    /// Uses standard cron syntax.
    cron_expression: ?[]const u8,

    pub const json_field_names = .{
        .cron_expression = "CronExpression",
    };
};
