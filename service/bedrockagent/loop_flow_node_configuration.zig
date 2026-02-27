const FlowDefinition = @import("flow_definition.zig").FlowDefinition;

/// Contains configurations for the nodes of a DoWhile loop in your flow.
///
/// A DoWhile loop is made up of the following nodes:
///
/// * `Loop` - The container node that holds the loop's flow definition. This
///   node encompasses the entire loop structure.
/// * `LoopInput` - The entry point node for the loop. This node receives inputs
///   from nodes outside the loop and from previous loop iterations.
/// * Body nodes - The processing nodes that execute within each loop iteration.
///   These can be nodes for handling data in your flow, such as a prompt or
///   Lambda function nodes. Some node types aren't supported inside a DoWhile
///   loop body. For more information, see
///   [LoopIncompatibleNodeTypeFlowValidationDetails](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_LoopIncompatibleNodeTypeFlowValidationDetails.html).
/// * `LoopController` - The node that evaluates whether the loop should
///   continue or exit based on a condition.
///
/// These nodes work together to create a loop that runs at least once and
/// continues until a specified condition is met or a maximum number of
/// iterations is reached.
pub const LoopFlowNodeConfiguration = struct {
    /// The definition of the DoWhile loop nodes and connections between nodes in
    /// the flow.
    definition: FlowDefinition,

    pub const json_field_names = .{
        .definition = "definition",
    };
};
