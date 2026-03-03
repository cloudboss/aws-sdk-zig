/// Encloses data related to a successful message in a batch request for topic.
pub const PublishBatchResultEntry = struct {
    /// The `Id` of an entry in a batch request.
    id: ?[]const u8 = null,

    /// An identifier for the message.
    message_id: ?[]const u8 = null,

    /// This parameter applies only to FIFO (first-in-first-out) topics.
    ///
    /// The large, non-consecutive number that Amazon SNS assigns to each message.
    ///
    /// The length of `SequenceNumber` is 128 bits. `SequenceNumber`
    /// continues to increase for a particular `MessageGroupId`.
    sequence_number: ?[]const u8 = null,
};
