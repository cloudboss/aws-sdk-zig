/// A data point in a dependency query range.
pub const QueryDataPoint = struct {
    /// The number of queries at this data point.
    query_count: i64,

    /// The timestamp of the data point.
    timestamp: i64,

    pub const json_field_names = .{
        .query_count = "queryCount",
        .timestamp = "timestamp",
    };
};
