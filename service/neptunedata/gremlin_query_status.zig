const QueryEvalStats = @import("query_eval_stats.zig").QueryEvalStats;

/// Captures the status of a Gremlin query (see the [Gremlin query status
/// API](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-api-status.html) page).
pub const GremlinQueryStatus = struct {
    /// The query statistics of the Gremlin query.
    query_eval_stats: ?QueryEvalStats = null,

    /// The ID of the Gremlin query.
    query_id: ?[]const u8 = null,

    /// The query string of the Gremlin query.
    query_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_eval_stats = "queryEvalStats",
        .query_id = "queryId",
        .query_string = "queryString",
    };
};
