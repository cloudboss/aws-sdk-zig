const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;

/// Summary of information about the last monitoring job to run.
pub const MonitoringExecutionSummary = struct {
    /// The time at which the monitoring job was created.
    creation_time: i64,

    /// The name of the endpoint used to run the monitoring job.
    endpoint_name: ?[]const u8,

    /// Contains the reason a monitoring job failed, if it failed.
    failure_reason: ?[]const u8,

    /// A timestamp that indicates the last time the monitoring job was modified.
    last_modified_time: i64,

    /// The status of the monitoring job.
    monitoring_execution_status: ExecutionStatus,

    /// The name of the monitoring job.
    monitoring_job_definition_name: ?[]const u8,

    /// The name of the monitoring schedule.
    monitoring_schedule_name: []const u8,

    /// The type of the monitoring job.
    monitoring_type: ?MonitoringType,

    /// The Amazon Resource Name (ARN) of the monitoring job.
    processing_job_arn: ?[]const u8,

    /// The time the monitoring job was scheduled.
    scheduled_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_name = "EndpointName",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .monitoring_execution_status = "MonitoringExecutionStatus",
        .monitoring_job_definition_name = "MonitoringJobDefinitionName",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .monitoring_type = "MonitoringType",
        .processing_job_arn = "ProcessingJobArn",
        .scheduled_time = "ScheduledTime",
    };
};
