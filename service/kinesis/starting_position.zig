const ShardIteratorType = @import("shard_iterator_type.zig").ShardIteratorType;

/// The starting position in the data stream from which to start streaming.
pub const StartingPosition = struct {
    /// The sequence number of the data record in the shard from which to start
    /// streaming. To
    /// specify a sequence number, set `StartingPosition` to
    /// `AT_SEQUENCE_NUMBER` or `AFTER_SEQUENCE_NUMBER`.
    sequence_number: ?[]const u8,

    /// The time stamp of the data record from which to start reading. To specify a
    /// time
    /// stamp, set `StartingPosition` to `Type AT_TIMESTAMP`. A time stamp
    /// is the Unix epoch date with precision in milliseconds. For example,
    /// `2016-04-04T19:58:46.480-00:00` or `1459799926.480`. If a
    /// record with this exact time stamp does not exist, records will be streamed
    /// from the next
    /// (later) record. If the time stamp is older than the current trim horizon,
    /// records will
    /// be streamed from the oldest untrimmed data record (`TRIM_HORIZON`).
    timestamp: ?i64,

    /// You can set the starting position to one of the following values:
    ///
    /// `AT_SEQUENCE_NUMBER`: Start streaming from the position denoted by the
    /// sequence number specified in the `SequenceNumber` field.
    ///
    /// `AFTER_SEQUENCE_NUMBER`: Start streaming right after the position denoted
    /// by the sequence number specified in the `SequenceNumber` field.
    ///
    /// `AT_TIMESTAMP`: Start streaming from the position denoted by the time stamp
    /// specified in the `Timestamp` field.
    ///
    /// `TRIM_HORIZON`: Start streaming at the last untrimmed record in the shard,
    /// which is the oldest data record in the shard.
    ///
    /// `LATEST`: Start streaming just after the most recent record in the shard,
    /// so that you always read the most recent data in the shard.
    type: ShardIteratorType,

    pub const json_field_names = .{
        .sequence_number = "SequenceNumber",
        .timestamp = "Timestamp",
        .type = "Type",
    };
};
