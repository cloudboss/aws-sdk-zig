/// Information about a node.
pub const NodeStructure = struct {
    /// The number of instances of this node.
    count: ?i64,

    /// The outgoing edge labels associated with this node.
    distinct_outgoing_edge_labels: ?[]const []const u8,

    /// Properties associated with this node.
    node_properties: ?[]const []const u8,

    pub const json_field_names = .{
        .count = "count",
        .distinct_outgoing_edge_labels = "distinctOutgoingEdgeLabels",
        .node_properties = "nodeProperties",
    };
};
