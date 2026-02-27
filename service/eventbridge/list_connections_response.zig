const Connection = @import("connection.zig").Connection;

pub const ListConnectionsResponse = struct {
    /// An array of connections objects that include details about the connections.
    connections: ?[]const Connection,

    /// A token indicating there are more results available. If there are no more
    /// results, no token is included in the response.
    ///
    /// The value of `nextToken` is a unique pagination token for each page. To
    /// retrieve the next page of results, make the call again using
    /// the returned token. Keep all other arguments unchanged.
    ///
    /// Using an expired pagination token results in an `HTTP 400 InvalidToken`
    /// error.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .connections = "Connections",
        .next_token = "NextToken",
    };
};
