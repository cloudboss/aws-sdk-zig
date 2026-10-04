/// Contains statistics about a completed query execution.
pub const QueryStatistics = struct {
    /// The total number of bytes scanned during query execution.
    bytes_scanned: i64,

    /// The total query execution time, in milliseconds.
    execution_time_in_millis: i64,

    /// The total number of rows returned by the query.
    row_count: i64,

    pub const json_field_names = .{
        .bytes_scanned = "bytesScanned",
        .execution_time_in_millis = "executionTimeInMillis",
        .row_count = "rowCount",
    };
};
