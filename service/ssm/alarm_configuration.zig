const Alarm = @import("alarm.zig").Alarm;

/// The details for the CloudWatch alarm you want to apply to an automation or
/// command.
pub const AlarmConfiguration = struct {
    /// The name of the CloudWatch alarm specified in the configuration.
    alarms: []const Alarm,

    /// When this value is *true*, your automation or command continues to run in
    /// cases where we can’t retrieve alarm status information from CloudWatch. In
    /// cases
    /// where we successfully retrieve an alarm status of OK or INSUFFICIENT_DATA,
    /// the automation or
    /// command continues to run, regardless of this value. Default is *false*.
    ignore_poll_alarm_failure: ?bool,

    pub const json_field_names = .{
        .alarms = "Alarms",
        .ignore_poll_alarm_failure = "IgnorePollAlarmFailure",
    };
};
