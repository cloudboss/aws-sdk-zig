const FailureDetails = @import("failure_details.zig").FailureDetails;
const StepState = @import("step_state.zig").StepState;
const StepStateChangeReason = @import("step_state_change_reason.zig").StepStateChangeReason;
const StepTimeline = @import("step_timeline.zig").StepTimeline;

/// The execution status details of the cluster step.
pub const StepStatus = struct {
    /// The details for the step failure including reason, message, and log file
    /// path where the
    /// root cause was identified.
    failure_details: ?FailureDetails = null,

    /// The execution state of the cluster step.
    state: ?StepState = null,

    /// The reason for the step execution status change.
    state_change_reason: ?StepStateChangeReason = null,

    /// The timeline of the cluster step status over time.
    timeline: ?StepTimeline = null,

    pub const json_field_names = .{
        .failure_details = "FailureDetails",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .timeline = "Timeline",
    };
};
