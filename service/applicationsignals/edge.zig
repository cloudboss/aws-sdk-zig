const ConnectionType = @import("connection_type.zig").ConnectionType;

/// A structure that represents a connection between two nodes in a dependency
/// graph, showing the relationship and characteristics of the connection.
pub const Edge = struct {
    /// The type of connection between the nodes, indicating the nature of the
    /// relationship.
    connection_type: ?ConnectionType,

    /// The identifier of the destination node in this edge connection.
    destination_node_id: ?[]const u8,

    /// The duration or latency associated with this connection, if applicable.
    duration: ?f64,

    /// The identifier of the source node in this edge connection.
    source_node_id: ?[]const u8,

    pub const json_field_names = .{
        .connection_type = "ConnectionType",
        .destination_node_id = "DestinationNodeId",
        .duration = "Duration",
        .source_node_id = "SourceNodeId",
    };
};
