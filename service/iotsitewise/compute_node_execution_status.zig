const ComputeNodeExecutionState = @import("compute_node_execution_state.zig").ComputeNodeExecutionState;
const ComputeNodeExecutionStateDetails = @import("compute_node_execution_state_details.zig").ComputeNodeExecutionStateDetails;

/// Current execution status of a compute node within a pipeline execution.
pub const ComputeNodeExecutionStatus = struct {
    /// Current state of the compute node execution.
    state: ComputeNodeExecutionState,

    /// Additional information about the compute node's failure. Populated when the
    /// compute node has failed.
    state_details: ?ComputeNodeExecutionStateDetails = null,

    pub const json_field_names = .{
        .state = "state",
        .state_details = "stateDetails",
    };
};
