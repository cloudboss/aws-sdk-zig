/// Statistics related to the processing of a query statement.
pub const ExecutionStatistics = struct {
    /// The average time the request took to be executed.
    average_execution_time_millis: i64 = 0,

    /// The amount of data that was scanned in bytes.
    data_scanned_bytes: i64 = 0,

    /// The number of work units executed.
    work_units_executed_count: i64 = 0,

    pub const json_field_names = .{
        .average_execution_time_millis = "AverageExecutionTimeMillis",
        .data_scanned_bytes = "DataScannedBytes",
        .work_units_executed_count = "WorkUnitsExecutedCount",
    };
};
