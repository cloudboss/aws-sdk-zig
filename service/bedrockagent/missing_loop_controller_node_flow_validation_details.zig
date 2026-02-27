/// Details about a flow that's missing a required `LoopController` node in a
/// DoWhile loop.
pub const MissingLoopControllerNodeFlowValidationDetails = struct {
    /// The DoWhile loop in a flow that's missing a required `LoopController` node.
    loop_node: []const u8,

    pub const json_field_names = .{
        .loop_node = "loopNode",
    };
};
