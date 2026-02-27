/// Metadata about a query, such as the number of results.
pub const QueryStatistics = struct {
    /// The total bytes that the query scanned in the event data store. This value
    /// matches the
    /// number of bytes for which your account is billed for the query, unless the
    /// query is still
    /// running.
    bytes_scanned: ?i64,

    /// The number of results returned.
    results_count: ?i32,

    /// The total number of results returned by a query.
    total_results_count: ?i32,

    pub const json_field_names = .{
        .bytes_scanned = "BytesScanned",
        .results_count = "ResultsCount",
        .total_results_count = "TotalResultsCount",
    };
};
