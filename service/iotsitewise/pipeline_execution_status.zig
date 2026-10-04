const PipelineExecutionState = @import("pipeline_execution_state.zig").PipelineExecutionState;
const PipelineExecutionStateDetails = @import("pipeline_execution_state_details.zig").PipelineExecutionStateDetails;

/// Current execution status of a pipeline.
pub const PipelineExecutionStatus = struct {
    /// Current state of the pipeline execution.
    state: PipelineExecutionState,

    /// Additional information about the execution outcome. Populated when the
    /// execution has terminated (failed or cancelled).
    state_details: ?PipelineExecutionStateDetails = null,

    pub const json_field_names = .{
        .state = "state",
        .state_details = "stateDetails",
    };
};
