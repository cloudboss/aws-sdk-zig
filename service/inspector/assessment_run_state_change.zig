const AssessmentRunState = @import("assessment_run_state.zig").AssessmentRunState;

/// Used as one of the elements of the AssessmentRun data
/// type.
pub const AssessmentRunStateChange = struct {
    /// The assessment run state.
    state: AssessmentRunState,

    /// The last time the assessment run state changed.
    state_changed_at: i64,

    pub const json_field_names = .{
        .state = "state",
        .state_changed_at = "stateChangedAt",
    };
};
