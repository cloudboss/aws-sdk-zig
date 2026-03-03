const ErrorInfo = @import("error_info.zig").ErrorInfo;

/// Specifies the end result of the flow run.
pub const ExecutionResult = struct {
    /// The total number of bytes processed by the flow run.
    bytes_processed: ?i64 = null,

    /// The total number of bytes written as a result of the flow run.
    bytes_written: ?i64 = null,

    /// Provides any error message information related to the flow run.
    error_info: ?ErrorInfo = null,

    /// The maximum number of records that Amazon AppFlow receives in each page of
    /// the
    /// response from your SAP application.
    max_page_size: ?i64 = null,

    /// The number of processes that Amazon AppFlow ran at the same time when it
    /// retrieved
    /// your data.
    num_parallel_processes: ?i64 = null,

    /// The number of records processed in the flow run.
    records_processed: ?i64 = null,

    pub const json_field_names = .{
        .bytes_processed = "bytesProcessed",
        .bytes_written = "bytesWritten",
        .error_info = "errorInfo",
        .max_page_size = "maxPageSize",
        .num_parallel_processes = "numParallelProcesses",
        .records_processed = "recordsProcessed",
    };
};
