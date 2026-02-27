/// Timeline statistics such as query queue time, planning time, execution time,
/// service
/// processing time, and total execution time.
pub const QueryRuntimeStatisticsTimeline = struct {
    /// The number of milliseconds that the query took to execute.
    engine_execution_time_in_millis: ?i64,

    /// The number of milliseconds that Athena took to plan the query processing
    /// flow. This includes the time spent retrieving table partitions from the data
    /// source.
    /// Note that because the query engine performs the query planning, query
    /// planning time is a
    /// subset of engine processing time.
    query_planning_time_in_millis: ?i64,

    /// The number of milliseconds that the query was in your query queue waiting
    /// for
    /// resources. Note that if transient errors occur, Athena might automatically
    /// add the query back to the queue.
    query_queue_time_in_millis: ?i64,

    /// The number of milliseconds that Athena spends on preprocessing before it
    /// submits the query to the engine.
    service_pre_processing_time_in_millis: ?i64,

    /// The number of milliseconds that Athena took to finalize and publish the
    /// query results after the query engine finished running the query.
    service_processing_time_in_millis: ?i64,

    /// The number of milliseconds that Athena took to run the query.
    total_execution_time_in_millis: ?i64,

    pub const json_field_names = .{
        .engine_execution_time_in_millis = "EngineExecutionTimeInMillis",
        .query_planning_time_in_millis = "QueryPlanningTimeInMillis",
        .query_queue_time_in_millis = "QueryQueueTimeInMillis",
        .service_pre_processing_time_in_millis = "ServicePreProcessingTimeInMillis",
        .service_processing_time_in_millis = "ServiceProcessingTimeInMillis",
        .total_execution_time_in_millis = "TotalExecutionTimeInMillis",
    };
};
