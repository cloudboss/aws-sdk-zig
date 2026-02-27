/// A node structure.
pub const NodeStructure = struct {
    /// Number of nodes that have this specific structure.
    count: ?i64,

    /// A list of distinct outgoing edge labels present in this specific structure.
    distinct_outgoing_edge_labels: ?[]const []const u8,

    /// A list of the node properties present in this specific structure.
    node_properties: ?[]const []const u8,

    pub const json_field_names = .{
        .count = "count",
        .distinct_outgoing_edge_labels = "distinctOutgoingEdgeLabels",
        .node_properties = "nodeProperties",
    };
};
