const ConnectionState = @import("connection_state.zig").ConnectionState;

pub const ListConnectionsRequest = struct {
    /// The state of the connection.
    connection_state: ?ConnectionState = null,

    /// The maximum number of connections to return.
    limit: ?i32 = null,

    /// A name prefix to filter results returned. Only connections with a name that
    /// starts with
    /// the prefix are returned.
    name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_state = "ConnectionState",
        .limit = "Limit",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
    };
};
