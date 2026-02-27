/// The parameters for using a Amazon SQS stream as a source.
pub const PipeSourceSqsQueueParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
    };
};
