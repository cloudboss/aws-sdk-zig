const ConnectorOperationStepState = @import("connector_operation_step_state.zig").ConnectorOperationStepState;
const ConnectorOperationStepType = @import("connector_operation_step_type.zig").ConnectorOperationStepType;

/// Details of a step that is involved in a connector's operation.
pub const ConnectorOperationStep = struct {
    /// The step state of the operation.
    step_state: ?ConnectorOperationStepState = null,

    /// The step type of the operation.
    step_type: ?ConnectorOperationStepType = null,

    pub const json_field_names = .{
        .step_state = "stepState",
        .step_type = "stepType",
    };
};
