const HealthStatus = @import("health_status.zig").HealthStatus;
const ScheduleConfig = @import("schedule_config.zig").ScheduleConfig;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

/// Contains the full configuration and metadata of a scheduled report.
pub const ScheduledReport = struct {
    /// The ARN of the scheduled report.
    arn: ?[]const u8 = null,

    /// The timestamp when the scheduled report was created.
    created_at: ?i64 = null,

    /// The ARN of the dashboard associated with the scheduled report.
    dashboard_arn: []const u8,

    /// A description of the scheduled report's purpose or contents.
    description: ?[]const u8 = null,

    /// The health status of the scheduled report at last refresh time.
    health_status: ?HealthStatus = null,

    /// The timestamp of the most recent execution of the scheduled report.
    last_execution_at: ?i64 = null,

    /// The name of the scheduled report.
    name: []const u8,

    /// The schedule configuration that defines when and how often the report is
    /// generated.
    schedule_config: ScheduleConfig,

    /// The ARN of the IAM role that the scheduled report uses to execute. Amazon
    /// Web Services Billing and Cost Management Dashboards will assume this IAM
    /// role while executing the scheduled report.
    scheduled_report_execution_role_arn: []const u8,

    /// The timestamp when the scheduled report was last modified.
    updated_at: ?i64 = null,

    /// The date range override applied to widgets in the scheduled report.
    widget_date_range_override: ?DateTimeRange = null,

    /// The list of widget identifiers included in the scheduled report.
    widget_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .dashboard_arn = "dashboardArn",
        .description = "description",
        .health_status = "healthStatus",
        .last_execution_at = "lastExecutionAt",
        .name = "name",
        .schedule_config = "scheduleConfig",
        .scheduled_report_execution_role_arn = "scheduledReportExecutionRoleArn",
        .updated_at = "updatedAt",
        .widget_date_range_override = "widgetDateRangeOverride",
        .widget_ids = "widgetIds",
    };
};
