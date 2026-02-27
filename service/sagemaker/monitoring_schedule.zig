const MonitoringExecutionSummary = @import("monitoring_execution_summary.zig").MonitoringExecutionSummary;
const MonitoringScheduleConfig = @import("monitoring_schedule_config.zig").MonitoringScheduleConfig;
const ScheduleStatus = @import("schedule_status.zig").ScheduleStatus;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;
const Tag = @import("tag.zig").Tag;

/// A schedule for a model monitoring job. For information about model monitor,
/// see [Amazon SageMaker Model
/// Monitor](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor.html).
pub const MonitoringSchedule = struct {
    /// The time that the monitoring schedule was created.
    creation_time: ?i64,

    /// The endpoint that hosts the model being monitored.
    endpoint_name: ?[]const u8,

    /// If the monitoring schedule failed, the reason it failed.
    failure_reason: ?[]const u8,

    /// The last time the monitoring schedule was changed.
    last_modified_time: ?i64,

    last_monitoring_execution_summary: ?MonitoringExecutionSummary,

    /// The Amazon Resource Name (ARN) of the monitoring schedule.
    monitoring_schedule_arn: ?[]const u8,

    monitoring_schedule_config: ?MonitoringScheduleConfig,

    /// The name of the monitoring schedule.
    monitoring_schedule_name: ?[]const u8,

    /// The status of the monitoring schedule. This can be one of the following
    /// values.
    ///
    /// * `PENDING` - The schedule is pending being created.
    /// * `FAILED` - The schedule failed.
    /// * `SCHEDULED` - The schedule was successfully created.
    /// * `STOPPED` - The schedule was stopped.
    monitoring_schedule_status: ?ScheduleStatus,

    /// The type of the monitoring job definition to schedule.
    monitoring_type: ?MonitoringType,

    /// A list of the tags associated with the monitoring schedlue. For more
    /// information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_name = "EndpointName",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .last_monitoring_execution_summary = "LastMonitoringExecutionSummary",
        .monitoring_schedule_arn = "MonitoringScheduleArn",
        .monitoring_schedule_config = "MonitoringScheduleConfig",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .monitoring_schedule_status = "MonitoringScheduleStatus",
        .monitoring_type = "MonitoringType",
        .tags = "Tags",
    };
};
