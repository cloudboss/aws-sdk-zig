/// An object that represents the details of a multi-node parallel job node.
pub const NodeDetails = struct {
    /// Specifies whether the current node is the main node for a multi-node
    /// parallel job.
    is_main_node: ?bool,

    /// The node index for the node. Node index numbering starts at zero. This index
    /// is also
    /// available on the node with the `AWS_BATCH_JOB_NODE_INDEX` environment
    /// variable.
    node_index: ?i32,

    pub const json_field_names = .{
        .is_main_node = "isMainNode",
        .node_index = "nodeIndex",
    };
};
