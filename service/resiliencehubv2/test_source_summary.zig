const ObservabilityAlarmSummary = @import("observability_alarm_summary.zig").ObservabilityAlarmSummary;
const SuccessCriteriaAlarmSummary = @import("success_criteria_alarm_summary.zig").SuccessCriteriaAlarmSummary;

/// A configured monitoring source returned by ListTestSources. Exactly one
/// member is set.
pub const TestSourceSummary = union(enum) {
    /// A configured observability alarm.
    observability_alarm: ?ObservabilityAlarmSummary,
    /// A configured success criteria alarm.
    success_criteria_alarm: ?SuccessCriteriaAlarmSummary,

    pub const json_field_names = .{
        .observability_alarm = "observabilityAlarm",
        .success_criteria_alarm = "successCriteriaAlarm",
    };
};
