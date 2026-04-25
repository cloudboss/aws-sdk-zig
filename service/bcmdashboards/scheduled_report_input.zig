const ScheduleConfig = @import("schedule_config.zig").ScheduleConfig;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

/// Defines the configuration for creating a new scheduled report, including the
/// dashboard, schedule, execution role, and optional widget settings.
pub const ScheduledReportInput = struct {
    /// The ARN of the dashboard to generate the scheduled report from.
    dashboard_arn: []const u8,

    /// A description of the scheduled report's purpose or contents.
    description: ?[]const u8 = null,

    /// The name of the scheduled report.
    name: []const u8,

    /// The schedule configuration that defines when and how often the report is
    /// generated. If the schedule state is not specified, it defaults to `ENABLED`.
    schedule_config: ScheduleConfig,

    /// The ARN of the IAM role that the scheduled report uses to execute. Amazon
    /// Web Services Billing and Cost Management Dashboards will assume this IAM
    /// role while executing the scheduled report.
    scheduled_report_execution_role_arn: []const u8,

    /// The date range override to apply to widgets in the scheduled report.
    widget_date_range_override: ?DateTimeRange = null,

    /// The list of widget identifiers to include in the scheduled report. If not
    /// specified, all widgets in the dashboard are included.
    widget_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .dashboard_arn = "dashboardArn",
        .description = "description",
        .name = "name",
        .schedule_config = "scheduleConfig",
        .scheduled_report_execution_role_arn = "scheduledReportExecutionRoleArn",
        .widget_date_range_override = "widgetDateRangeOverride",
        .widget_ids = "widgetIds",
    };
};
