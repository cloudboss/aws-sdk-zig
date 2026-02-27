/// Details about a flow that contains multiple `LoopController` nodes in a
/// DoWhile loop.
pub const MultipleLoopControllerNodesFlowValidationDetails = struct {
    /// The DoWhile loop in a flow that contains multiple `LoopController` nodes.
    loop_node: []const u8,

    pub const json_field_names = .{
        .loop_node = "loopNode",
    };
};
