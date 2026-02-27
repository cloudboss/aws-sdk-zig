/// Details about a flow that's missing a required `LoopInput` node in a DoWhile
/// loop.
pub const MissingLoopInputNodeFlowValidationDetails = struct {
    /// The DoWhile loop in a flow that's missing a required `LoopInput` node.
    loop_node: []const u8,

    pub const json_field_names = .{
        .loop_node = "loopNode",
    };
};
