const ChildShard = @import("child_shard.zig").ChildShard;
const Record = @import("record.zig").Record;

/// After you call SubscribeToShard, Kinesis Data Streams sends events
/// of this type over an HTTP/2 connection to your consumer.
pub const SubscribeToShardEvent = struct {
    /// The list of the child shards of the current shard, returned only at the end
    /// of the
    /// current shard.
    child_shards: ?[]const ChildShard = null,

    /// Use this as `SequenceNumber` in the next call to SubscribeToShard, with
    /// `StartingPosition` set to
    /// `AT_SEQUENCE_NUMBER` or `AFTER_SEQUENCE_NUMBER`. Use
    /// `ContinuationSequenceNumber` for checkpointing because it captures your
    /// shard progress even when no data is written to the shard.
    continuation_sequence_number: []const u8,

    /// The number of milliseconds the read records are from the tip of the stream,
    /// indicating
    /// how far behind current time the consumer is. A value of zero indicates that
    /// record
    /// processing is caught up, and there are no new records to process at this
    /// moment.
    millis_behind_latest: i64,

    records: []const Record,

    pub const json_field_names = .{
        .child_shards = "ChildShards",
        .continuation_sequence_number = "ContinuationSequenceNumber",
        .millis_behind_latest = "MillisBehindLatest",
        .records = "Records",
    };
};
