/// The templated target type for the Amazon Kinesis [
/// `PutRecord`
/// ](kinesis/latest/APIReference/API_PutRecord.html) API operation.
pub const KinesisParameters = struct {
    /// Specifies the shard to which EventBridge Scheduler sends the event. For more
    /// information, see [Amazon Kinesis Data Streams terminology and
    /// concepts](https://docs.aws.amazon.com/streams/latest/dev/key-concepts.html)
    /// in the
    /// *Amazon Kinesis Streams Developer Guide*.
    partition_key: []const u8,

    pub const json_field_names = .{
        .partition_key = "PartitionKey",
    };
};
