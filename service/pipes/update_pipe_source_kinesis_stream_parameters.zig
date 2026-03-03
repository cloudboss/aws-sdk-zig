const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const OnPartialBatchItemFailureStreams = @import("on_partial_batch_item_failure_streams.zig").OnPartialBatchItemFailureStreams;

/// The parameters for using a Kinesis stream as a source.
pub const UpdatePipeSourceKinesisStreamParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32 = null,

    /// Define the target queue to send dead-letter queue events to.
    dead_letter_config: ?DeadLetterConfig = null,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32 = null,

    /// Discard records older than the specified age. The default value is -1, which
    /// sets the maximum age to infinite.
    /// When the value is set to infinite, EventBridge never discards old records.
    maximum_record_age_in_seconds: ?i32 = null,

    /// Discard records after the specified number of retries. The default value is
    /// -1, which sets the maximum number of
    /// retries to infinite. When MaximumRetryAttempts is infinite, EventBridge
    /// retries failed records until the record expires in the event source.
    maximum_retry_attempts: ?i32 = null,

    /// Define how to handle item process failures. `AUTOMATIC_BISECT` halves each
    /// batch and retry each half
    /// until all the records are processed or there is one failed message left in
    /// the batch.
    on_partial_batch_item_failure: ?OnPartialBatchItemFailureStreams = null,

    /// The number of batches to process concurrently from each shard. The default
    /// value is 1.
    parallelization_factor: ?i32 = null,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .dead_letter_config = "DeadLetterConfig",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
        .maximum_record_age_in_seconds = "MaximumRecordAgeInSeconds",
        .maximum_retry_attempts = "MaximumRetryAttempts",
        .on_partial_batch_item_failure = "OnPartialBatchItemFailure",
        .parallelization_factor = "ParallelizationFactor",
    };
};
