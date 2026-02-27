/// Configuration settings for batching.
pub const BatchConfig = struct {
    /// The maximum amount of time (in milliseconds) that an outgoing call waits for
    /// other calls
    /// with which it batches messages of the same type. The higher the setting, the
    /// longer the
    /// latency of the batched HTTP Action will be.
    max_batch_open_ms: ?i32,

    /// The maximum number of messages that are batched together in a single action
    /// execution.
    max_batch_size: ?i32,

    /// Maximum size of a message batch, in bytes.
    max_batch_size_bytes: ?i32,

    pub const json_field_names = .{
        .max_batch_open_ms = "maxBatchOpenMs",
        .max_batch_size = "maxBatchSize",
        .max_batch_size_bytes = "maxBatchSizeBytes",
    };
};
