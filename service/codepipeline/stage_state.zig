const ActionState = @import("action_state.zig").ActionState;
const StageConditionState = @import("stage_condition_state.zig").StageConditionState;
const StageExecution = @import("stage_execution.zig").StageExecution;
const TransitionState = @import("transition_state.zig").TransitionState;
const RetryStageMetadata = @import("retry_stage_metadata.zig").RetryStageMetadata;

/// Represents information about the state of the stage.
pub const StageState = struct {
    /// The state of the stage.
    action_states: ?[]const ActionState,

    /// The state of the entry conditions for a stage.
    before_entry_condition_state: ?StageConditionState,

    inbound_execution: ?StageExecution,

    /// The inbound executions for a stage.
    inbound_executions: ?[]const StageExecution,

    /// The state of the inbound transition, which is either enabled or disabled.
    inbound_transition_state: ?TransitionState,

    /// Information about the latest execution in the stage, including its ID and
    /// status.
    latest_execution: ?StageExecution,

    /// The state of the failure conditions for a stage.
    on_failure_condition_state: ?StageConditionState,

    /// The state of the success conditions for a stage.
    on_success_condition_state: ?StageConditionState,

    /// he details of a specific automatic retry on stage failure, including the
    /// attempt
    /// number and trigger.
    retry_stage_metadata: ?RetryStageMetadata,

    /// The name of the stage.
    stage_name: ?[]const u8,

    pub const json_field_names = .{
        .action_states = "actionStates",
        .before_entry_condition_state = "beforeEntryConditionState",
        .inbound_execution = "inboundExecution",
        .inbound_executions = "inboundExecutions",
        .inbound_transition_state = "inboundTransitionState",
        .latest_execution = "latestExecution",
        .on_failure_condition_state = "onFailureConditionState",
        .on_success_condition_state = "onSuccessConditionState",
        .retry_stage_metadata = "retryStageMetadata",
        .stage_name = "stageName",
    };
};
