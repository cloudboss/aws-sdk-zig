const AlarmState = @import("alarm_state.zig").AlarmState;

/// Details about a CloudWatch alarm state change observed during a test run.
pub const AlarmStateChangeDetail = struct {
    /// The state the alarm transitioned from. Absent on the initial event, which
    /// records the alarm's state when collection began.
    previous_state: ?AlarmState = null,

    /// A human-readable explanation of the state change, as reported by CloudWatch.
    reason: ?[]const u8 = null,

    /// The state the alarm transitioned to.
    state: AlarmState,

    pub const json_field_names = .{
        .previous_state = "previousState",
        .reason = "reason",
        .state = "state",
    };
};
