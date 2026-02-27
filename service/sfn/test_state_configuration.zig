/// Contains configurations for the tested state.
pub const TestStateConfiguration = struct {
    /// The name of the state from which an error originates when an error is mocked
    /// for a Map or Parallel state.
    error_caused_by_state: ?[]const u8,

    /// The data read by ItemReader in Distributed Map states as found in its
    /// original source.
    map_item_reader_data: ?[]const u8,

    /// The number of Map state iterations that failed during the Map state
    /// invocation.
    map_iteration_failure_count: ?i32,

    /// The number of retry attempts that have occurred for the state's Retry that
    /// applies to the mocked error.
    retrier_retry_count: ?i32,

    pub const json_field_names = .{
        .error_caused_by_state = "errorCausedByState",
        .map_item_reader_data = "mapItemReaderData",
        .map_iteration_failure_count = "mapIterationFailureCount",
        .retrier_retry_count = "retrierRetryCount",
    };
};
