/// Gets metadata about a query, including the number of events that were
/// matched, the total
/// number of events scanned, the query run time in milliseconds, and the
/// query's creation
/// time.
pub const QueryStatisticsForDescribeQuery = struct {
    /// The total bytes that the query scanned in the event data store. This value
    /// matches the
    /// number of bytes for which your account is billed for the query, unless the
    /// query is still
    /// running.
    bytes_scanned: ?i64 = null,

    /// The creation time of the query.
    creation_time: ?i64 = null,

    /// The number of events that matched a query.
    events_matched: ?i64 = null,

    /// The number of events that the query scanned in the event data store.
    events_scanned: ?i64 = null,

    /// The query's run time, in milliseconds.
    execution_time_in_millis: ?i32 = null,

    pub const json_field_names = .{
        .bytes_scanned = "BytesScanned",
        .creation_time = "CreationTime",
        .events_matched = "EventsMatched",
        .events_scanned = "EventsScanned",
        .execution_time_in_millis = "ExecutionTimeInMillis",
    };
};
