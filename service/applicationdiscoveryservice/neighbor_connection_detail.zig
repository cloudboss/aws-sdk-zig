/// Details about neighboring servers.
pub const NeighborConnectionDetail = struct {
    /// The number of open network connections with the neighboring server.
    connections_count: i64 = 0,

    /// The destination network port for the connection.
    destination_port: ?i32,

    /// The ID of the server that accepted the network connection.
    destination_server_id: []const u8,

    /// The ID of the server that opened the network connection.
    source_server_id: []const u8,

    /// The network protocol used for the connection.
    transport_protocol: ?[]const u8,

    pub const json_field_names = .{
        .connections_count = "connectionsCount",
        .destination_port = "destinationPort",
        .destination_server_id = "destinationServerId",
        .source_server_id = "sourceServerId",
        .transport_protocol = "transportProtocol",
    };
};
