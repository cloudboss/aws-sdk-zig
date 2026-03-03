const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// The unit of data of the Kinesis data stream, which is composed of a sequence
/// number, a
/// partition key, and a data blob.
pub const Record = struct {
    /// The approximate time that the record was inserted into the stream.
    approximate_arrival_timestamp: ?i64 = null,

    /// The data blob. The data in the blob is both opaque and immutable to Kinesis
    /// Data
    /// Streams, which does not inspect, interpret, or change the data in the blob
    /// in any way.
    /// When the data blob (the payload before base64-encoding) is added to the
    /// partition key
    /// size, the total size must not exceed the maximum record size (1 MiB).
    data: []const u8,

    /// The encryption type used on the record. This parameter can be one of the
    /// following
    /// values:
    ///
    /// * `NONE`: Do not encrypt the records in the stream.
    ///
    /// * `KMS`: Use server-side encryption on the records in the stream
    /// using a customer-managed Amazon Web Services KMS key.
    encryption_type: ?EncryptionType = null,

    /// Identifies which shard in the stream the data record is assigned to.
    partition_key: []const u8,

    /// The unique identifier of the record within its shard.
    sequence_number: []const u8,

    pub const json_field_names = .{
        .approximate_arrival_timestamp = "ApproximateArrivalTimestamp",
        .data = "Data",
        .encryption_type = "EncryptionType",
        .partition_key = "PartitionKey",
        .sequence_number = "SequenceNumber",
    };
};
