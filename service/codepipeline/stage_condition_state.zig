const ConditionState = @import("condition_state.zig").ConditionState;
const StageConditionsExecution = @import("stage_conditions_execution.zig").StageConditionsExecution;

/// The state of a run of a condition for a stage.
pub const StageConditionState = struct {
    /// The states of the conditions for a run of a condition for a stage.
    condition_states: ?[]const ConditionState = null,

    /// Represents information about the latest run of a condition for a stage.
    latest_execution: ?StageConditionsExecution = null,

    pub const json_field_names = .{
        .condition_states = "conditionStates",
        .latest_execution = "latestExecution",
    };
};
