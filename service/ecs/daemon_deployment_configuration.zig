const DaemonAlarmConfiguration = @import("daemon_alarm_configuration.zig").DaemonAlarmConfiguration;

/// Optional deployment parameters that control how a daemon rolls out updates
/// across container instances.
pub const DaemonDeploymentConfiguration = struct {
    /// The CloudWatch alarm configuration for the daemon deployment. When alarms
    /// are triggered during a deployment, the deployment can be automatically
    /// rolled back.
    alarms: ?DaemonAlarmConfiguration = null,

    /// The amount of time (in minutes) to wait after a successful deployment step
    /// before proceeding. This allows time to monitor for issues before continuing.
    /// The default value is 0.
    bake_time_in_minutes: i32 = 0,

    /// The percentage of container instances to drain simultaneously during a
    /// daemon deployment. Valid values are between 0.0 and 100.0.
    drain_percent: ?f64 = null,

    pub const json_field_names = .{
        .alarms = "alarms",
        .bake_time_in_minutes = "bakeTimeInMinutes",
        .drain_percent = "drainPercent",
    };
};
