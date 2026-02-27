const ScheduleStatus = @import("schedule_status.zig").ScheduleStatus;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;

/// Summarizes the monitoring schedule.
pub const MonitoringScheduleSummary = struct {
    /// The creation time of the monitoring schedule.
    creation_time: i64,

    /// The name of the endpoint using the monitoring schedule.
    endpoint_name: ?[]const u8,

    /// The last time the monitoring schedule was modified.
    last_modified_time: i64,

    /// The name of the monitoring job definition that the schedule is for.
    monitoring_job_definition_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the monitoring schedule.
    monitoring_schedule_arn: []const u8,

    /// The name of the monitoring schedule.
    monitoring_schedule_name: []const u8,

    /// The status of the monitoring schedule.
    monitoring_schedule_status: ScheduleStatus,

    /// The type of the monitoring job definition that the schedule is for.
    monitoring_type: ?MonitoringType,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_name = "EndpointName",
        .last_modified_time = "LastModifiedTime",
        .monitoring_job_definition_name = "MonitoringJobDefinitionName",
        .monitoring_schedule_arn = "MonitoringScheduleArn",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .monitoring_schedule_status = "MonitoringScheduleStatus",
        .monitoring_type = "MonitoringType",
    };
};
