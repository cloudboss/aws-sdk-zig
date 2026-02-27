/// Statistics for a single scheduled query run.
pub const ExecutionStats = struct {
    /// Bytes metered for a single scheduled query run.
    bytes_metered: i64 = 0,

    /// Bytes scanned for a single scheduled query run.
    cumulative_bytes_scanned: i64 = 0,

    /// Data writes metered for records ingested in a single scheduled query run.
    data_writes: i64 = 0,

    /// Total time, measured in milliseconds, that was needed for the scheduled
    /// query run to
    /// complete.
    execution_time_in_millis: i64 = 0,

    /// Number of rows present in the output from running a query before ingestion
    /// to
    /// destination data source.
    query_result_rows: i64 = 0,

    /// The number of records ingested for a single scheduled query run.
    records_ingested: i64 = 0,

    pub const json_field_names = .{
        .bytes_metered = "BytesMetered",
        .cumulative_bytes_scanned = "CumulativeBytesScanned",
        .data_writes = "DataWrites",
        .execution_time_in_millis = "ExecutionTimeInMillis",
        .query_result_rows = "QueryResultRows",
        .records_ingested = "RecordsIngested",
    };
};
