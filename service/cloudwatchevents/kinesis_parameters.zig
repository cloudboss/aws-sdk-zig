/// This object enables you to specify a JSON path to extract from the event and
/// use as the
/// partition key for the Amazon Kinesis data stream, so that you can control
/// the shard to which
/// the event goes. If you do not include this parameter, the default is to use
/// the
/// `eventId` as the partition key.
pub const KinesisParameters = struct {
    /// The JSON path to be extracted from the event and used as the partition key.
    /// For more
    /// information, see [Amazon Kinesis Streams Key
    /// Concepts](https://docs.aws.amazon.com/streams/latest/dev/key-concepts.html#partition-key) in the *Amazon Kinesis Streams Developer Guide*.
    partition_key_path: []const u8,

    pub const json_field_names = .{
        .partition_key_path = "PartitionKeyPath",
    };
};
