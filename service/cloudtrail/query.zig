const QueryStatus = @import("query_status.zig").QueryStatus;

/// A SQL string of criteria about events that you want to collect in an event
/// data
/// store.
pub const Query = struct {
    /// The creation time of a query.
    creation_time: ?i64 = null,

    /// The ID of a query.
    query_id: ?[]const u8 = null,

    /// The status of the query. This can be `QUEUED`, `RUNNING`,
    /// `FINISHED`, `FAILED`, `TIMED_OUT`, or
    /// `CANCELLED`.
    query_status: ?QueryStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .query_id = "QueryId",
        .query_status = "QueryStatus",
    };
};
