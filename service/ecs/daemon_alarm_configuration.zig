/// The CloudWatch alarm configuration for a daemon. When enabled, CloudWatch
/// alarms determine whether a daemon deployment has failed.
pub const DaemonAlarmConfiguration = struct {
    /// The CloudWatch alarm names to monitor during a daemon deployment.
    alarm_names: ?[]const []const u8 = null,

    /// Determines whether to use the CloudWatch alarm option in the daemon
    /// deployment process. The default value is `false`.
    enable: bool = false,

    pub const json_field_names = .{
        .alarm_names = "alarmNames",
        .enable = "enable",
    };
};
