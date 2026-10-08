const TestRunObservabilityAlarmSummary = @import("test_run_observability_alarm_summary.zig").TestRunObservabilityAlarmSummary;
const TestRunSuccessCriteriaAlarmSummary = @import("test_run_success_criteria_alarm_summary.zig").TestRunSuccessCriteriaAlarmSummary;

/// A monitoring-source snapshot captured for a test run. Exactly one member is
/// set.
pub const TestRunSourceSummary = union(enum) {
    /// An observability alarm snapshot captured for the test run.
    observability_alarm: ?TestRunObservabilityAlarmSummary,
    /// A success criteria alarm snapshot captured for the test run.
    success_criteria_alarm: ?TestRunSuccessCriteriaAlarmSummary,

    pub const json_field_names = .{
        .observability_alarm = "observabilityAlarm",
        .success_criteria_alarm = "successCriteriaAlarm",
    };
};
