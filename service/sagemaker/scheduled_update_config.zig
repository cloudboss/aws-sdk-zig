const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;

/// The configuration object of the schedule that SageMaker follows when
/// updating the AMI.
pub const ScheduledUpdateConfig = struct {
    /// The configuration to use when updating the AMI versions.
    deployment_config: ?DeploymentConfiguration = null,

    /// A cron expression that specifies the schedule that SageMaker follows when
    /// updating the AMI.
    schedule_expression: []const u8,

    pub const json_field_names = .{
        .deployment_config = "DeploymentConfig",
        .schedule_expression = "ScheduleExpression",
    };
};
