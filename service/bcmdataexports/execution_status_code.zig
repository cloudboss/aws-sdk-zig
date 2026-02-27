pub const ExecutionStatusCode = enum {
    initiation_in_process,
    query_queued,
    query_in_process,
    query_failure,
    delivery_in_process,
    delivery_success,
    delivery_failure,

    pub const json_field_names = .{
        .initiation_in_process = "INITIATION_IN_PROCESS",
        .query_queued = "QUERY_QUEUED",
        .query_in_process = "QUERY_IN_PROCESS",
        .query_failure = "QUERY_FAILURE",
        .delivery_in_process = "DELIVERY_IN_PROCESS",
        .delivery_success = "DELIVERY_SUCCESS",
        .delivery_failure = "DELIVERY_FAILURE",
    };
};
