/// The batching configuration of an InfluxDB rule action. IoT closes a batch
/// and writes
/// it to InfluxDB when the first of the configured limits is reached.
pub const InfluxDBBatchConfig = struct {
    /// Specifies whether to collect data points from different topics into the same
    /// batch.
    ///
    /// If omitted or `false`, IoT batches data points for each topic
    /// separately.
    batch_across_topics: bool = false,

    /// The maximum length of time, in milliseconds, to keep a batch open before
    /// writing it to
    /// InfluxDB.
    ///
    /// If you don't specify a value, this limit doesn't apply. IoT then closes each
    /// batch
    /// when another configured limit is reached.
    max_batch_open_ms: ?i32 = null,

    /// The maximum number of data points to collect in a batch.
    ///
    /// If you don't specify a value, this limit doesn't apply. IoT then closes each
    /// batch
    /// when another configured limit is reached.
    max_batch_size: ?i32 = null,

    /// The maximum size of a batch, in bytes, before IoT writes it to InfluxDB.
    ///
    /// If you don't specify a value, this limit doesn't apply. IoT then closes each
    /// batch
    /// when another configured limit is reached.
    max_batch_size_bytes: ?i32 = null,

    pub const json_field_names = .{
        .batch_across_topics = "batchAcrossTopics",
        .max_batch_open_ms = "maxBatchOpenMs",
        .max_batch_size = "maxBatchSize",
        .max_batch_size_bytes = "maxBatchSizeBytes",
    };
};
