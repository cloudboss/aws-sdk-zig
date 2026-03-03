/// Contains information about an edge in a Neptune Analytics graph.
pub const EdgeStructure = struct {
    /// The number of instances of the edge in the graph.
    count: ?i64 = null,

    /// A list of the properties associated with the edge.
    edge_properties: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .count = "count",
        .edge_properties = "edgeProperties",
    };
};
