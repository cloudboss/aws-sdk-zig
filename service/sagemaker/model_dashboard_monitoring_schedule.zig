const BatchTransformInput = @import("batch_transform_input.zig").BatchTransformInput;
const MonitoringExecutionSummary = @import("monitoring_execution_summary.zig").MonitoringExecutionSummary;
const MonitoringAlertSummary = @import("monitoring_alert_summary.zig").MonitoringAlertSummary;
const MonitoringScheduleConfig = @import("monitoring_schedule_config.zig").MonitoringScheduleConfig;
const ScheduleStatus = @import("schedule_status.zig").ScheduleStatus;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;

/// A monitoring schedule for a model displayed in the Amazon SageMaker Model
/// Dashboard.
pub const ModelDashboardMonitoringSchedule = struct {
    batch_transform_input: ?BatchTransformInput = null,

    /// A timestamp that indicates when the monitoring schedule was created.
    creation_time: ?i64 = null,

    /// The endpoint which is monitored.
    endpoint_name: ?[]const u8 = null,

    /// If a monitoring job failed, provides the reason.
    failure_reason: ?[]const u8 = null,

    /// A timestamp that indicates when the monitoring schedule was last updated.
    last_modified_time: ?i64 = null,

    last_monitoring_execution_summary: ?MonitoringExecutionSummary = null,

    /// A JSON array where each element is a summary for a monitoring alert.
    monitoring_alert_summaries: ?[]const MonitoringAlertSummary = null,

    /// The Amazon Resource Name (ARN) of a monitoring schedule.
    monitoring_schedule_arn: ?[]const u8 = null,

    monitoring_schedule_config: ?MonitoringScheduleConfig = null,

    /// The name of a monitoring schedule.
    monitoring_schedule_name: ?[]const u8 = null,

    /// The status of the monitoring schedule.
    monitoring_schedule_status: ?ScheduleStatus = null,

    /// The monitor type of a model monitor.
    monitoring_type: ?MonitoringType = null,

    pub const json_field_names = .{
        .batch_transform_input = "BatchTransformInput",
        .creation_time = "CreationTime",
        .endpoint_name = "EndpointName",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .last_monitoring_execution_summary = "LastMonitoringExecutionSummary",
        .monitoring_alert_summaries = "MonitoringAlertSummaries",
        .monitoring_schedule_arn = "MonitoringScheduleArn",
        .monitoring_schedule_config = "MonitoringScheduleConfig",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .monitoring_schedule_status = "MonitoringScheduleStatus",
        .monitoring_type = "MonitoringType",
    };
};
