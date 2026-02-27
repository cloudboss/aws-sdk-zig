const QueryState = @import("query_state.zig").QueryState;

/// Details of the query listed.
pub const QuerySummary = struct {
    /// The running time of the query, in milliseconds.
    elapsed: ?i32,

    /// A string representation of the id of the query.
    id: ?[]const u8,

    /// The actual query text. The `queryString` may be truncated if the actual
    /// query string is too long.
    query_string: ?[]const u8,

    /// State of the query.
    state: ?QueryState,

    /// The amount of time, in milliseconds, the query has waited in the queue
    /// before being picked up by a worker thread.
    waited: ?i32,

    pub const json_field_names = .{
        .elapsed = "elapsed",
        .id = "id",
        .query_string = "queryString",
        .state = "state",
        .waited = "waited",
    };
};
