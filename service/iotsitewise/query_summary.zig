const QueryStatus = @import("query_status.zig").QueryStatus;

/// Contains summary information about a query.
pub const QuerySummary = struct {
    /// The date and time when the query reached a terminal state, in Unix epoch
    /// time.
    completed_at: ?i64 = null,

    /// The unique identifier for the query execution.
    query_id: []const u8,

    /// The current query status.
    status: QueryStatus,

    /// The date and time when the query was submitted, in Unix epoch time.
    submitted_at: i64,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .query_id = "queryId",
        .status = "status",
        .submitted_at = "submittedAt",
    };
};
