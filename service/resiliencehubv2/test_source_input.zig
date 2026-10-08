const ObservabilityAlarmInput = @import("observability_alarm_input.zig").ObservabilityAlarmInput;
const SuccessCriteriaAlarmInput = @import("success_criteria_alarm_input.zig").SuccessCriteriaAlarmInput;

/// Identifies a monitoring source to add to or remove from a test. Exactly one
/// member is set.
pub const TestSourceInput = union(enum) {
    /// An observability alarm included for visibility only.
    observability_alarm: ?ObservabilityAlarmInput,
    /// A success criteria alarm that determines whether the test passes or fails.
    success_criteria_alarm: ?SuccessCriteriaAlarmInput,

    pub const json_field_names = .{
        .observability_alarm = "observabilityAlarm",
        .success_criteria_alarm = "successCriteriaAlarm",
    };
};
