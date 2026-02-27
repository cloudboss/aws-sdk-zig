/// An object that represents the properties of a node that's associated with a
/// multi-node
/// parallel job.
pub const NodePropertiesSummary = struct {
    /// Specifies whether the current node is the main node for a multi-node
    /// parallel job.
    is_main_node: ?bool,

    /// The node index for the node. Node index numbering begins at zero. This index
    /// is also
    /// available on the node with the `AWS_BATCH_JOB_NODE_INDEX` environment
    /// variable.
    node_index: ?i32,

    /// The number of nodes that are associated with a multi-node parallel job.
    num_nodes: ?i32,

    pub const json_field_names = .{
        .is_main_node = "isMainNode",
        .node_index = "nodeIndex",
        .num_nodes = "numNodes",
    };
};
