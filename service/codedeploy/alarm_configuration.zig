const Alarm = @import("alarm.zig").Alarm;

/// Information about alarms associated with a deployment or deployment group.
pub const AlarmConfiguration = struct {
    /// A list of alarms configured for the deployment or deployment group. A
    /// maximum of 10
    /// alarms can be added.
    alarms: ?[]const Alarm = null,

    /// Indicates whether the alarm configuration is enabled.
    enabled: bool = false,

    /// Indicates whether a deployment should continue if information about the
    /// current state
    /// of alarms cannot be retrieved from Amazon CloudWatch. The default value is
    /// false.
    ///
    /// * `true`: The deployment proceeds even if alarm status information
    /// can't be retrieved from Amazon CloudWatch.
    ///
    /// * `false`: The deployment stops if alarm status information can't be
    /// retrieved from Amazon CloudWatch.
    ignore_poll_alarm_failure: bool = false,

    pub const json_field_names = .{
        .alarms = "alarms",
        .enabled = "enabled",
        .ignore_poll_alarm_failure = "ignorePollAlarmFailure",
    };
};
