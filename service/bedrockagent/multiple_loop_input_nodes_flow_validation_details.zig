/// Details about a flow that contains multiple `LoopInput` nodes in a DoWhile
/// loop.
pub const MultipleLoopInputNodesFlowValidationDetails = struct {
    /// The DoWhile loop in a flow that contains multiple `LoopInput` nodes.
    loop_node: []const u8,

    pub const json_field_names = .{
        .loop_node = "loopNode",
    };
};
