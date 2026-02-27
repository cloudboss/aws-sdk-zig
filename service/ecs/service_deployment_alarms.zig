const ServiceDeploymentRollbackMonitorsStatus = @import("service_deployment_rollback_monitors_status.zig").ServiceDeploymentRollbackMonitorsStatus;

/// The CloudWatch alarms used to determine a service deployment failed.
///
/// Amazon ECS considers the service deployment as failed when any of the alarms
/// move to
/// the `ALARM` state. For more information, see [How CloudWatch
/// alarms detect Amazon ECS deployment
/// failures](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-alarm-failure.html) in the Amazon ECS Developer
/// Guide.
pub const ServiceDeploymentAlarms = struct {
    /// The name of the CloudWatch alarms that determine when a service deployment
    /// failed. A
    /// "," separates the alarms.
    alarm_names: ?[]const []const u8,

    /// The status of the alarms check. Amazon ECS is not using alarms for service
    /// deployment
    /// failures when the status is `DISABLED`.
    status: ?ServiceDeploymentRollbackMonitorsStatus,

    /// One or more CloudWatch alarm names that have been triggered during the
    /// service
    /// deployment. A "," separates the alarm names.
    triggered_alarm_names: ?[]const []const u8,

    pub const json_field_names = .{
        .alarm_names = "alarmNames",
        .status = "status",
        .triggered_alarm_names = "triggeredAlarmNames",
    };
};
