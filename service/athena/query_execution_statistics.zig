const ResultReuseInformation = @import("result_reuse_information.zig").ResultReuseInformation;

/// The amount of data scanned during the query execution and the amount of time
/// that it
/// took to execute, and the type of statement that was run.
pub const QueryExecutionStatistics = struct {
    /// The location and file name of a data manifest file. The manifest file is
    /// saved to the
    /// Athena query results location in Amazon S3. The manifest file
    /// tracks files that the query wrote to Amazon S3. If the query fails, the
    /// manifest
    /// file also tracks files that the query intended to write. The manifest is
    /// useful for
    /// identifying orphaned files resulting from a failed query. For more
    /// information, see
    /// [Working with Query
    /// Results, Output Files, and Query
    /// History](https://docs.aws.amazon.com/athena/latest/ug/querying.html) in the
    /// *Amazon Athena User Guide*.
    data_manifest_location: ?[]const u8 = null,

    /// The number of bytes in the data that was queried.
    data_scanned_in_bytes: ?i64 = null,

    /// The number of Data Processing Units (DPUs) that Athena used to run the
    /// query.
    dpu_count: ?f64 = null,

    /// The number of milliseconds that the query took to execute.
    engine_execution_time_in_millis: ?i64 = null,

    /// The number of milliseconds that Athena took to plan the query processing
    /// flow. This includes the time spent retrieving table partitions from the data
    /// source.
    /// Note that because the query engine performs the query planning, query
    /// planning time is a
    /// subset of engine processing time.
    query_planning_time_in_millis: ?i64 = null,

    /// The number of milliseconds that the query was in your query queue waiting
    /// for
    /// resources. Note that if transient errors occur, Athena might automatically
    /// add the query back to the queue.
    query_queue_time_in_millis: ?i64 = null,

    /// Contains information about whether previous query results were reused for
    /// the
    /// query.
    result_reuse_information: ?ResultReuseInformation = null,

    /// The number of milliseconds that Athena took to preprocess the query before
    /// submitting the query to the query engine.
    service_pre_processing_time_in_millis: ?i64 = null,

    /// The number of milliseconds that Athena took to finalize and publish the
    /// query results after the query engine finished running the query.
    service_processing_time_in_millis: ?i64 = null,

    /// The number of milliseconds that Athena took to run the query.
    total_execution_time_in_millis: ?i64 = null,

    pub const json_field_names = .{
        .data_manifest_location = "DataManifestLocation",
        .data_scanned_in_bytes = "DataScannedInBytes",
        .dpu_count = "DpuCount",
        .engine_execution_time_in_millis = "EngineExecutionTimeInMillis",
        .query_planning_time_in_millis = "QueryPlanningTimeInMillis",
        .query_queue_time_in_millis = "QueryQueueTimeInMillis",
        .result_reuse_information = "ResultReuseInformation",
        .service_pre_processing_time_in_millis = "ServicePreProcessingTimeInMillis",
        .service_processing_time_in_millis = "ServiceProcessingTimeInMillis",
        .total_execution_time_in_millis = "TotalExecutionTimeInMillis",
    };
};
