const AlarmAction = @import("alarm_action.zig").AlarmAction;

/// Contains information about one or more alarm actions.
pub const AlarmEventActions = struct {
    /// Specifies one or more supported actions to receive notifications when the
    /// alarm state
    /// changes.
    alarm_actions: ?[]const AlarmAction = null,

    pub const json_field_names = .{
        .alarm_actions = "alarmActions",
    };
};
