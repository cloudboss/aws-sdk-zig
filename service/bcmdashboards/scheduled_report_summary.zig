const HealthStatus = @import("health_status.zig").HealthStatus;
const ScheduleState = @import("schedule_state.zig").ScheduleState;

/// Contains summary information for a scheduled report.
pub const ScheduledReportSummary = struct {
    /// The ARN of the scheduled report.
    arn: []const u8,

    /// The ARN of the dashboard associated with the scheduled report.
    dashboard_arn: []const u8,

    /// The health status of the scheduled report as of its last refresh time.
    health_status: HealthStatus,

    /// The name of the scheduled report.
    name: []const u8,

    /// The schedule expression that defines when the report runs.
    schedule_expression: []const u8,

    /// The time zone for the schedule expression, for example, `UTC`.
    schedule_expression_time_zone: ?[]const u8 = null,

    /// The state of the schedule: `ENABLED` or `DISABLED`.
    state: ScheduleState,

    /// The list of widget identifiers included in the scheduled report.
    widget_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .dashboard_arn = "dashboardArn",
        .health_status = "healthStatus",
        .name = "name",
        .schedule_expression = "scheduleExpression",
        .schedule_expression_time_zone = "scheduleExpressionTimeZone",
        .state = "state",
        .widget_ids = "widgetIds",
    };
};
