const DaemonDeploymentRollbackMonitorsStatus = @import("daemon_deployment_rollback_monitors_status.zig").DaemonDeploymentRollbackMonitorsStatus;

/// The CloudWatch alarms used to determine a daemon deployment failed.
pub const DaemonDeploymentAlarms = struct {
    /// The name of the CloudWatch alarms that determine when a daemon deployment
    /// failed.
    alarm_names: ?[]const []const u8 = null,

    /// The status of the alarms check. Amazon ECS is not using alarms for daemon
    /// deployment failures when the status is `DISABLED`.
    status: ?DaemonDeploymentRollbackMonitorsStatus = null,

    /// One or more CloudWatch alarm names that have been triggered during the
    /// daemon deployment.
    triggered_alarm_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .alarm_names = "alarmNames",
        .status = "status",
        .triggered_alarm_names = "triggeredAlarmNames",
    };
};
