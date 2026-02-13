const ExternalAlarmState = @import("external_alarm_state.zig").ExternalAlarmState;

/// The details about the state of your CloudWatch alarm.
pub const AlarmStateInformation = struct {
    /// The name of your CloudWatch alarm.
    name: []const u8,

    /// The state of your CloudWatch alarm.
    state: ExternalAlarmState,

    pub const json_field_names = .{
        .name = "Name",
        .state = "State",
    };
};
