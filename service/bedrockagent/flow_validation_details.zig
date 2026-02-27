const CyclicConnectionFlowValidationDetails = @import("cyclic_connection_flow_validation_details.zig").CyclicConnectionFlowValidationDetails;
const DuplicateConditionExpressionFlowValidationDetails = @import("duplicate_condition_expression_flow_validation_details.zig").DuplicateConditionExpressionFlowValidationDetails;
const DuplicateConnectionsFlowValidationDetails = @import("duplicate_connections_flow_validation_details.zig").DuplicateConnectionsFlowValidationDetails;
const IncompatibleConnectionDataTypeFlowValidationDetails = @import("incompatible_connection_data_type_flow_validation_details.zig").IncompatibleConnectionDataTypeFlowValidationDetails;
const InvalidLoopBoundaryFlowValidationDetails = @import("invalid_loop_boundary_flow_validation_details.zig").InvalidLoopBoundaryFlowValidationDetails;
const LoopIncompatibleNodeTypeFlowValidationDetails = @import("loop_incompatible_node_type_flow_validation_details.zig").LoopIncompatibleNodeTypeFlowValidationDetails;
const MalformedConditionExpressionFlowValidationDetails = @import("malformed_condition_expression_flow_validation_details.zig").MalformedConditionExpressionFlowValidationDetails;
const MalformedNodeInputExpressionFlowValidationDetails = @import("malformed_node_input_expression_flow_validation_details.zig").MalformedNodeInputExpressionFlowValidationDetails;
const MismatchedNodeInputTypeFlowValidationDetails = @import("mismatched_node_input_type_flow_validation_details.zig").MismatchedNodeInputTypeFlowValidationDetails;
const MismatchedNodeOutputTypeFlowValidationDetails = @import("mismatched_node_output_type_flow_validation_details.zig").MismatchedNodeOutputTypeFlowValidationDetails;
const MissingConnectionConfigurationFlowValidationDetails = @import("missing_connection_configuration_flow_validation_details.zig").MissingConnectionConfigurationFlowValidationDetails;
const MissingDefaultConditionFlowValidationDetails = @import("missing_default_condition_flow_validation_details.zig").MissingDefaultConditionFlowValidationDetails;
const MissingEndingNodesFlowValidationDetails = @import("missing_ending_nodes_flow_validation_details.zig").MissingEndingNodesFlowValidationDetails;
const MissingLoopControllerNodeFlowValidationDetails = @import("missing_loop_controller_node_flow_validation_details.zig").MissingLoopControllerNodeFlowValidationDetails;
const MissingLoopInputNodeFlowValidationDetails = @import("missing_loop_input_node_flow_validation_details.zig").MissingLoopInputNodeFlowValidationDetails;
const MissingNodeConfigurationFlowValidationDetails = @import("missing_node_configuration_flow_validation_details.zig").MissingNodeConfigurationFlowValidationDetails;
const MissingNodeInputFlowValidationDetails = @import("missing_node_input_flow_validation_details.zig").MissingNodeInputFlowValidationDetails;
const MissingNodeOutputFlowValidationDetails = @import("missing_node_output_flow_validation_details.zig").MissingNodeOutputFlowValidationDetails;
const MissingStartingNodesFlowValidationDetails = @import("missing_starting_nodes_flow_validation_details.zig").MissingStartingNodesFlowValidationDetails;
const MultipleLoopControllerNodesFlowValidationDetails = @import("multiple_loop_controller_nodes_flow_validation_details.zig").MultipleLoopControllerNodesFlowValidationDetails;
const MultipleLoopInputNodesFlowValidationDetails = @import("multiple_loop_input_nodes_flow_validation_details.zig").MultipleLoopInputNodesFlowValidationDetails;
const MultipleNodeInputConnectionsFlowValidationDetails = @import("multiple_node_input_connections_flow_validation_details.zig").MultipleNodeInputConnectionsFlowValidationDetails;
const UnfulfilledNodeInputFlowValidationDetails = @import("unfulfilled_node_input_flow_validation_details.zig").UnfulfilledNodeInputFlowValidationDetails;
const UnknownConnectionConditionFlowValidationDetails = @import("unknown_connection_condition_flow_validation_details.zig").UnknownConnectionConditionFlowValidationDetails;
const UnknownConnectionSourceFlowValidationDetails = @import("unknown_connection_source_flow_validation_details.zig").UnknownConnectionSourceFlowValidationDetails;
const UnknownConnectionSourceOutputFlowValidationDetails = @import("unknown_connection_source_output_flow_validation_details.zig").UnknownConnectionSourceOutputFlowValidationDetails;
const UnknownConnectionTargetFlowValidationDetails = @import("unknown_connection_target_flow_validation_details.zig").UnknownConnectionTargetFlowValidationDetails;
const UnknownConnectionTargetInputFlowValidationDetails = @import("unknown_connection_target_input_flow_validation_details.zig").UnknownConnectionTargetInputFlowValidationDetails;
const UnknownNodeInputFlowValidationDetails = @import("unknown_node_input_flow_validation_details.zig").UnknownNodeInputFlowValidationDetails;
const UnknownNodeOutputFlowValidationDetails = @import("unknown_node_output_flow_validation_details.zig").UnknownNodeOutputFlowValidationDetails;
const UnreachableNodeFlowValidationDetails = @import("unreachable_node_flow_validation_details.zig").UnreachableNodeFlowValidationDetails;
const UnsatisfiedConnectionConditionsFlowValidationDetails = @import("unsatisfied_connection_conditions_flow_validation_details.zig").UnsatisfiedConnectionConditionsFlowValidationDetails;
const UnspecifiedFlowValidationDetails = @import("unspecified_flow_validation_details.zig").UnspecifiedFlowValidationDetails;

/// A union type containing various possible validation issues in the flow.
pub const FlowValidationDetails = union(enum) {
    /// Details about a cyclic connection in the flow.
    cyclic_connection: ?CyclicConnectionFlowValidationDetails,
    /// Details about duplicate condition expressions in a node.
    duplicate_condition_expression: ?DuplicateConditionExpressionFlowValidationDetails,
    /// Details about duplicate connections between nodes.
    duplicate_connections: ?DuplicateConnectionsFlowValidationDetails,
    /// Details about incompatible data types in a connection.
    incompatible_connection_data_type: ?IncompatibleConnectionDataTypeFlowValidationDetails,
    /// Details about a flow that includes connections that violate loop boundary
    /// rules.
    invalid_loop_boundary: ?InvalidLoopBoundaryFlowValidationDetails,
    /// Details about a flow that includes incompatible node types in a DoWhile
    /// loop.
    loop_incompatible_node_type: ?LoopIncompatibleNodeTypeFlowValidationDetails,
    /// Details about a malformed condition expression in a node.
    malformed_condition_expression: ?MalformedConditionExpressionFlowValidationDetails,
    /// Details about a malformed input expression in a node.
    malformed_node_input_expression: ?MalformedNodeInputExpressionFlowValidationDetails,
    /// Details about mismatched input data types in a node.
    mismatched_node_input_type: ?MismatchedNodeInputTypeFlowValidationDetails,
    /// Details about mismatched output data types in a node.
    mismatched_node_output_type: ?MismatchedNodeOutputTypeFlowValidationDetails,
    /// Details about missing configuration for a connection.
    missing_connection_configuration: ?MissingConnectionConfigurationFlowValidationDetails,
    /// Details about a missing default condition in a conditional node.
    missing_default_condition: ?MissingDefaultConditionFlowValidationDetails,
    /// Details about missing ending nodes in the flow.
    missing_ending_nodes: ?MissingEndingNodesFlowValidationDetails,
    /// Details about a flow that's missing a required `LoopController` node in a
    /// DoWhile loop.
    missing_loop_controller_node: ?MissingLoopControllerNodeFlowValidationDetails,
    /// Details about a flow that's missing a required `LoopInput` node in a DoWhile
    /// loop.
    missing_loop_input_node: ?MissingLoopInputNodeFlowValidationDetails,
    /// Details about missing configuration for a node.
    missing_node_configuration: ?MissingNodeConfigurationFlowValidationDetails,
    /// Details about a missing required input in a node.
    missing_node_input: ?MissingNodeInputFlowValidationDetails,
    /// Details about a missing required output in a node.
    missing_node_output: ?MissingNodeOutputFlowValidationDetails,
    /// Details about missing starting nodes in the flow.
    missing_starting_nodes: ?MissingStartingNodesFlowValidationDetails,
    /// Details about a flow that contains multiple `LoopController` nodes in a
    /// DoWhile loop.
    multiple_loop_controller_nodes: ?MultipleLoopControllerNodesFlowValidationDetails,
    /// Details about a flow that contains multiple `LoopInput` nodes in a DoWhile
    /// loop.
    multiple_loop_input_nodes: ?MultipleLoopInputNodesFlowValidationDetails,
    /// Details about multiple connections to a single node input.
    multiple_node_input_connections: ?MultipleNodeInputConnectionsFlowValidationDetails,
    /// Details about an unfulfilled node input with no valid connections.
    unfulfilled_node_input: ?UnfulfilledNodeInputFlowValidationDetails,
    /// Details about an unknown condition for a connection.
    unknown_connection_condition: ?UnknownConnectionConditionFlowValidationDetails,
    /// Details about an unknown source node for a connection.
    unknown_connection_source: ?UnknownConnectionSourceFlowValidationDetails,
    /// Details about an unknown source output for a connection.
    unknown_connection_source_output: ?UnknownConnectionSourceOutputFlowValidationDetails,
    /// Details about an unknown target node for a connection.
    unknown_connection_target: ?UnknownConnectionTargetFlowValidationDetails,
    /// Details about an unknown target input for a connection.
    unknown_connection_target_input: ?UnknownConnectionTargetInputFlowValidationDetails,
    /// Details about an unknown input for a node.
    unknown_node_input: ?UnknownNodeInputFlowValidationDetails,
    /// Details about an unknown output for a node.
    unknown_node_output: ?UnknownNodeOutputFlowValidationDetails,
    /// Details about an unreachable node in the flow.
    unreachable_node: ?UnreachableNodeFlowValidationDetails,
    /// Details about unsatisfied conditions for a connection.
    unsatisfied_connection_conditions: ?UnsatisfiedConnectionConditionsFlowValidationDetails,
    /// Details about an unspecified validation.
    unspecified: ?UnspecifiedFlowValidationDetails,

    pub const json_field_names = .{
        .cyclic_connection = "cyclicConnection",
        .duplicate_condition_expression = "duplicateConditionExpression",
        .duplicate_connections = "duplicateConnections",
        .incompatible_connection_data_type = "incompatibleConnectionDataType",
        .invalid_loop_boundary = "invalidLoopBoundary",
        .loop_incompatible_node_type = "loopIncompatibleNodeType",
        .malformed_condition_expression = "malformedConditionExpression",
        .malformed_node_input_expression = "malformedNodeInputExpression",
        .mismatched_node_input_type = "mismatchedNodeInputType",
        .mismatched_node_output_type = "mismatchedNodeOutputType",
        .missing_connection_configuration = "missingConnectionConfiguration",
        .missing_default_condition = "missingDefaultCondition",
        .missing_ending_nodes = "missingEndingNodes",
        .missing_loop_controller_node = "missingLoopControllerNode",
        .missing_loop_input_node = "missingLoopInputNode",
        .missing_node_configuration = "missingNodeConfiguration",
        .missing_node_input = "missingNodeInput",
        .missing_node_output = "missingNodeOutput",
        .missing_starting_nodes = "missingStartingNodes",
        .multiple_loop_controller_nodes = "multipleLoopControllerNodes",
        .multiple_loop_input_nodes = "multipleLoopInputNodes",
        .multiple_node_input_connections = "multipleNodeInputConnections",
        .unfulfilled_node_input = "unfulfilledNodeInput",
        .unknown_connection_condition = "unknownConnectionCondition",
        .unknown_connection_source = "unknownConnectionSource",
        .unknown_connection_source_output = "unknownConnectionSourceOutput",
        .unknown_connection_target = "unknownConnectionTarget",
        .unknown_connection_target_input = "unknownConnectionTargetInput",
        .unknown_node_input = "unknownNodeInput",
        .unknown_node_output = "unknownNodeOutput",
        .unreachable_node = "unreachableNode",
        .unsatisfied_connection_conditions = "unsatisfiedConnectionConditions",
        .unspecified = "unspecified",
    };
};
