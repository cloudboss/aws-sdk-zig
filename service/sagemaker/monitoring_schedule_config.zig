const MonitoringJobDefinition = @import("monitoring_job_definition.zig").MonitoringJobDefinition;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;
const ScheduleConfig = @import("schedule_config.zig").ScheduleConfig;

/// Configures the monitoring schedule and defines the monitoring job.
pub const MonitoringScheduleConfig = struct {
    /// Defines the monitoring job.
    monitoring_job_definition: ?MonitoringJobDefinition,

    /// The name of the monitoring job definition to schedule.
    monitoring_job_definition_name: ?[]const u8,

    /// The type of the monitoring job definition to schedule.
    monitoring_type: ?MonitoringType,

    /// Configures the monitoring schedule.
    schedule_config: ?ScheduleConfig,

    pub const json_field_names = .{
        .monitoring_job_definition = "MonitoringJobDefinition",
        .monitoring_job_definition_name = "MonitoringJobDefinitionName",
        .monitoring_type = "MonitoringType",
        .schedule_config = "ScheduleConfig",
    };
};
