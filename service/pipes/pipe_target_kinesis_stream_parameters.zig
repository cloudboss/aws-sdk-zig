/// The parameters for using a Kinesis stream as a target.
pub const PipeTargetKinesisStreamParameters = struct {
    /// Determines which shard in the stream the data record is assigned to.
    /// Partition keys are
    /// Unicode strings with a maximum length limit of 256 characters for each key.
    /// Amazon Kinesis Data Streams uses the partition key as input to a hash
    /// function that maps the
    /// partition key and associated data to a specific shard. Specifically, an MD5
    /// hash function
    /// is used to map partition keys to 128-bit integer values and to map
    /// associated data records
    /// to shards. As a result of this hashing mechanism, all data records with the
    /// same partition
    /// key map to the same shard within the stream.
    partition_key: []const u8,

    pub const json_field_names = .{
        .partition_key = "PartitionKey",
    };
};
