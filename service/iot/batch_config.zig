/// Configuration settings for batching.
pub const BatchConfig = struct {
    /// Whether to allow batching messages from different MQTT topics into a single
    /// HTTP request.
    /// By default, only messages from the same topic are batched together. The
    /// default value is `false`.
    batch_across_topics: bool = false,

    /// The maximum amount of time (in milliseconds) that an outgoing call waits for
    /// other calls
    /// with which it batches messages of the same type. The higher the setting, the
    /// longer the
    /// latency of the batched HTTP Action will be.
    max_batch_open_ms: ?i32 = null,

    /// The maximum number of messages that are batched together in a single action
    /// execution.
    max_batch_size: ?i32 = null,

    /// Maximum size of a message batch, in bytes.
    max_batch_size_bytes: ?i32 = null,

    pub const json_field_names = .{
        .batch_across_topics = "batchAcrossTopics",
        .max_batch_open_ms = "maxBatchOpenMs",
        .max_batch_size = "maxBatchSize",
        .max_batch_size_bytes = "maxBatchSizeBytes",
    };
};
