const CustomerAction = @import("customer_action.zig").CustomerAction;
const RuleEvaluation = @import("rule_evaluation.zig").RuleEvaluation;
const AlarmStateName = @import("alarm_state_name.zig").AlarmStateName;
const SystemEvent = @import("system_event.zig").SystemEvent;

/// Contains information about the current state of the alarm.
pub const AlarmState = struct {
    /// Contains information about the action that you can take to respond to the
    /// alarm.
    customer_action: ?CustomerAction = null,

    /// Information needed to evaluate data.
    rule_evaluation: ?RuleEvaluation = null,

    /// The name of the alarm state. The state name can be one of the following
    /// values:
    ///
    /// * `DISABLED` - When the alarm is in the `DISABLED` state,
    /// it isn't ready to evaluate data. To enable the alarm,
    /// you must change the alarm to the `NORMAL` state.
    ///
    /// * `NORMAL` - When the alarm is in the `NORMAL` state,
    /// it's ready to evaluate data.
    ///
    /// * `ACTIVE` - If the alarm is in the `ACTIVE` state,
    /// the alarm is invoked.
    ///
    /// * `ACKNOWLEDGED` - When the alarm is in the `ACKNOWLEDGED` state,
    /// the alarm was invoked and you acknowledged the alarm.
    ///
    /// * `SNOOZE_DISABLED` - When the alarm is in the `SNOOZE_DISABLED` state,
    /// the alarm is disabled for a specified period of time. After the snooze time,
    /// the alarm automatically changes to the `NORMAL` state.
    ///
    /// * `LATCHED` - When the alarm is in the `LATCHED` state,
    /// the alarm was invoked. However, the data that the alarm is currently
    /// evaluating is within the specified range.
    /// To change the alarm to the `NORMAL` state, you must acknowledge the alarm.
    state_name: ?AlarmStateName = null,

    /// Contains information about alarm state changes.
    system_event: ?SystemEvent = null,

    pub const json_field_names = .{
        .customer_action = "customerAction",
        .rule_evaluation = "ruleEvaluation",
        .state_name = "stateName",
        .system_event = "systemEvent",
    };
};
