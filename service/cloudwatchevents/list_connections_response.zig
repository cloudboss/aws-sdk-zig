const Connection = @import("connection.zig").Connection;

pub const ListConnectionsResponse = struct {
    /// An array of connections objects that include details about the connections.
    connections: ?[]const Connection,

    /// A token you can use in a subsequent request to retrieve the next set of
    /// results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .connections = "Connections",
        .next_token = "NextToken",
    };
};
