const ConnectionType = @import("connection_type.zig").ConnectionType;

/// A structure that represents a connection between two nodes in a dependency
/// graph, showing the relationship and characteristics of the connection.
pub const Edge = struct {
    /// The type of connection between the nodes, indicating the nature of the
    /// relationship.
    connection_type: ?ConnectionType = null,

    /// The identifier of the destination node in this edge connection.
    destination_node_id: ?[]const u8 = null,

    /// The duration or latency associated with this connection, if applicable.
    duration: ?f64 = null,

    /// The identifier of the source node in this edge connection.
    source_node_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_type = "ConnectionType",
        .destination_node_id = "DestinationNodeId",
        .duration = "Duration",
        .source_node_id = "SourceNodeId",
    };
};
