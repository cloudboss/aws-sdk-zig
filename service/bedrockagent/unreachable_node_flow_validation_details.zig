/// Details about an unreachable node in the flow. A node is unreachable when
/// there are no paths to it from any starting node.
pub const UnreachableNodeFlowValidationDetails = struct {
    /// The name of the unreachable node.
    node: []const u8,

    pub const json_field_names = .{
        .node = "node",
    };
};
